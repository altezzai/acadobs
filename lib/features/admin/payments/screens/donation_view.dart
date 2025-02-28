import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';

class DonationView extends StatefulWidget {
  final Donation donation;
  DonationView({required this.donation});

  @override
  State<DonationView> createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  Future<void> _downloadFile(BuildContext context, String fileName) async {
    try {
      // Check and request storage permission
      if (await _requestPermission()) {
        final String baseUrl =
            'https://schoolmanagement.altezzai.com/admin/donations/';
        final String fileUrl = '$baseUrl$fileName';

        final response = await http.get(Uri.parse(fileUrl));
        if (response.statusCode == 200) {
          Directory? downloadsDirectory;

          if (Platform.isAndroid || Platform.isIOS) {
            downloadsDirectory = await getExternalStorageDirectory();
          } else if (Platform.isWindows ||
              Platform.isLinux ||
              Platform.isMacOS) {
            downloadsDirectory = await getDownloadsDirectory();
          } else {
            downloadsDirectory = await getTemporaryDirectory();
          }

          String filePath = '${downloadsDirectory!.path}/$fileName';
          File file = File(filePath);

          await file.writeAsBytes(response.bodyBytes);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully downloaded",
              style: TextStyle(color: Colors.green),
            ),
            backgroundColor: Colors.white,
          ));

          final result = await OpenFile.open(filePath);
          if (result.type != ResultType.done) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to open the file: ${result.message}'),
              ),
            );
          }
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

  Future<bool> _requestPermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }

    if (await Permission.manageExternalStorage.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    }

    return false;
  }

  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      Directory? directory = await getExternalStorageDirectory();
      String path = directory!.path.split("Android")[0] + "Download";
      directory = Directory(path);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return directory;
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: capitalizeEachWord(widget.donation.purpose ?? ""),
        isBackButton: true,
        actions: [
          Consumer<PaymentController>(builder: (context, value, child) {
            return CustomPopupMenu(onEdit: () {
              context.pushNamed(AppRouteConst.editDonationRouteName,
                  extra: widget.donation);
            }, onDelete: () {
              showConfirmationDialog(
                  context: context,
                  title: "Delete Donation?",
                  content: "Are you sure you want to delete this donation?",
                  onConfirm: () {
                    value.deleteDoantion(
                        context: context, donationId: widget.donation.id ?? 0);
                  });
            });
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // SizedBox(
            //   height: Responsive.height * 1,
            // ),
            // CustomAppbar(
            //   title: widget.donation.purpose ?? "",
            //   isProfileIcon: false,
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            SizedBox(height: Responsive.height * 2),
            CircleAvatar(
              backgroundImage: widget.donation.studentPhoto != null
                  ? NetworkImage(
                      "${baseUrl}${Urls.studentPhotos}${widget.donation.studentPhoto}")
                  : AssetImage('assets/child1.png') as ImageProvider,
              radius: 25,
            ),
            SizedBox(height: Responsive.height * 2),
            Text(
              'From ${capitalizeFirstLetter(widget.donation.fullName ?? "")}',
              style: textThemeData.bodyMedium,
            ),
            Text(
                '${widget.donation.donationClass ?? ""} ${widget.donation.section ?? ""}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Transaction Id : ',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.donation.transactionId ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height * 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green.shade100.withOpacity(0.2),
              ),
              child: Text(
                '₹${widget.donation.amountDonated}',
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: Responsive.height * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: Responsive.width * 2),
                Text('Completed', style: textThemeData.bodyMedium),
              ],
            ),
            SizedBox(height: Responsive.height * 1),
            Container(
              height: Responsive.height * .1,
              width: Responsive.width * 60,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: Responsive.height * 2),
            Text(
              '${DateFormatter.formatDateString(widget.donation.donationDate.toString())}  ${TimeFormatter.formatTimeFromString(
                widget.donation.createdAt.toString(),
              )}',
            ),
            SizedBox(height: Responsive.height * 3),

            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey),
            //     borderRadius: BorderRadius.circular(20.0),
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 16.0,
            //     vertical: 12.0,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           const Icon(
            //             Icons.file_copy_outlined,
            //             color: Colors.black,
            //           ),
            //           const SizedBox(width: 10),
            //           Text(
            //             (widget.donation.receiptUpload?.length ?? 0) > 25
            //                 ? '${widget.donation.receiptUpload!.substring(widget.donation.receiptUpload!.length - 25)}' // Last 10 characters
            //                 : widget.donation.receiptUpload ??
            //                     "No Documents Found!",
            //             style: const TextStyle(
            //               color: Colors.black,
            //               fontSize: 10,
            //             ),
            //           ),
            //         ],
            //       ),
            //       widget.donation.receiptUpload != null
            //           ? GestureDetector(
            //               onTap: () => _downloadFile(
            //                   context, widget.donation.receiptUpload ?? ""),
            //               child: const Icon(
            //                 Icons.download,
            //                 color: Colors.black,
            //               ),
            //             )
            //           : SizedBox.shrink()
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
