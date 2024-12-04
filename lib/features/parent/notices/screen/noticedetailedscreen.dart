// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:school_app/base/routes/app_route_const.dart';

// class NoticeDetailPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String fileName;
//   final ImageProvider imageProvider;

//   const NoticeDetailPage({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.fileName,
//     required this.imageProvider,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.chevron_left, color: Colors.black),
//           onPressed: () {
//             context.pushReplacementNamed(
//               AppRouteConst.ParentNoticePageRouteName,
//             );
//             // Navigator.of(context).pop();
//           },
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image section
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16.0),
//                   child: Image(
//                     image: imageProvider,
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Notice Title
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24,
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Notice Description
//               Text(
//                 description,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // PDF Download Section
//               GestureDetector(
//                 onTap: () {
//                   // Handle PDF download action here
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 12.0,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.picture_as_pdf_outlined,
//                             color: Colors.black,
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             fileName,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Icon(
//                         Icons.download,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:http/http.dart' as http;

class NoticeDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String fileUpload;
  final ImageProvider imageProvider;

  const NoticeDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.fileUpload,
    required this.imageProvider,
  });

  Future<void> _downloadFile(BuildContext context, String fileName) async {
    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        // Construct the full file URL
        final String baseUrl =
            'https://schoolmanagement.altezzai.com/admin/notices/';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushNamed(
              AppRouteConst.ParentNoticePageRouteName,
            );
          },
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image(
                    image: imageProvider,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Notice Title
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),

              // Notice Description
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // PDF Download Section
              GestureDetector(
                onTap: () => _downloadFile(context, fileUpload),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.picture_as_pdf_outlined,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            fileUpload,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
