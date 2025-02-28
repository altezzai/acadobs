import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';

class NoticeDetailPage extends StatelessWidget {
  final Notice notice;
  final UserType userType;

  const NoticeDetailPage({
    super.key,
    required this.notice,
    required this.userType,
  });

  Future<void> _downloadFile(BuildContext context, String fileName) async {
    try {
      // Check and request storage permission
      if (await _requestPermission()) {
        final String baseUrl =
            'https://schoolmanagement.altezzai.com/admin/notices/';
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
        title: capitalizeEachWord(notice.title ?? ""),
        isBackButton: true,
        actions: [
          if (userType == UserType.admin) // Show for admin only
            Consumer<NoticeController>(
              builder: (context, noticeController, child) {
                return CustomPopupMenu(onEdit: () {
                  context.pushNamed(AppRouteConst.editNoticeRouteName,
                      extra: notice);
                }, onDelete: () {
                  showConfirmationDialog(
                      context: context,
                      title: "Delete Notice?",
                      content: "Are you sure you want to delete this notice?",
                      onConfirm: () {
                        noticeController.deleteNotices(context,
                            noticeId: notice.id!);
                      });
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset('assets/class12.png'),
                ),
              ),
              SizedBox(height: Responsive.height * 2),
              Text(
                notice.title ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                notice.description ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: Responsive.height * 1),
              Row(
                children: [
                  Text(
                    "Date: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  Text(
                      "${DateFormatter.formatDateString(notice.date.toString())}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              Container(
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
                          Icons.file_copy_outlined,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          (notice.fileUpload?.length ?? 0) > 10
                              ? '${notice.fileUpload!.substring(notice.fileUpload!.length - 25)}' // Last 10 characters
                              : notice.fileUpload ?? "No Documents Found!",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    notice.fileUpload != null
                        ? GestureDetector(
                            onTap: () =>
                                _downloadFile(context, notice.fileUpload ?? ""),
                            child: const Icon(
                              Icons.download,
                              color: Colors.black,
                            ),
                          )
                        : SizedBox.shrink()
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
