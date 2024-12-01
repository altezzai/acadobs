import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_app/base/routes/app_route_const.dart';

class PaymentDetailPage extends StatefulWidget {
  final String amount;
  final String description;
  final dynamic file;
  final String transactionId;

  const PaymentDetailPage(
      {super.key,
      required this.amount,
      required this.description,
      required this.file,
      required this.transactionId});

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  Future<void> _downloadFile(BuildContext context, String fileName) async {
    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        // Construct the full file URL
        final String baseUrl =
            'https://schoolmanagement.altezzai.com/admin/monthly_payments/';
        final String fileUrl = '$baseUrl$fileName';

        // Send an HTTP GET request to download the file
        final http.Response response = await http.get(Uri.parse(fileUrl));

        if (response.statusCode == 200) {
          // Get the local downloads directory
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}$fileName';
          File file = File(filePath);

          // Write the downloaded file to the local storage
          await file.writeAsBytes(response.bodyBytes);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully downloaded",
              style: TextStyle(color: Colors.green),
            ),
            backgroundColor: Colors.white,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          )
              // SnackBar(content: Text('File downloaded to: $filePath')),
              );
          OpenFile.open(filePath);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to download file from server')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String desc = widget.description;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(
              AppRouteConst.ParentPaymentPageRouteName,
            );
          },
        ),
        title: const Text('Payments'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: desc == 'Completed'
                      ? Colors.green[100]
                      : desc == 'Failed'
                          ? Colors.red[100]
                          : Colors.orange[100],
                ),
                height: 250,
                width: 350,
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "₹ ${widget.amount}",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: widget.description == 'Completed'
                          ? Colors.green
                          : widget.description == 'Failed'
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    desc == 'Completed'
                        ? Icons.done_outline
                        : desc == 'Failed'
                            ? Icons.close
                            : Icons.pending_actions,
                    color: desc == 'Completed'
                        ? Colors.green
                        : desc == 'Failed'
                            ? Colors.red
                            : Colors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                        color: desc == 'Completed'
                            ? Colors.green
                            : desc == 'Failed'
                                ? Colors.red
                                : Colors.orange,
                        fontSize: 18),
                  ),
                ],
              ),
              Text("Transactiod Id:${widget.transactionId}"),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _downloadFile(context, widget.file);

                  // Code to download receit goes here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Download Receipt',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
