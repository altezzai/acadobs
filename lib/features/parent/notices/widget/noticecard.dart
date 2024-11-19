import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';

class NoticeCard extends StatelessWidget {
  final String noticeTitle;
  final String description;
  final String date;
  final String time;
  final String fileUpload;

  const NoticeCard({
    super.key,
    required this.noticeTitle,
    required this.date,
    required this.description,
    required this.time,
    required this.fileUpload,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushReplacementNamed(
          AppRouteConst.NoticeDetailedPageRouteName,
          extra: {
            'title': noticeTitle,
            'description': description,
            'fileUpload': fileUpload,

            // 'fileName': "Exam-details.pdf",
            'imageProvider': const AssetImage('assets/class12.png'),
          },
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => NoticeDetailPage(
        //       title: noticeTitle,
        //       description:
        //           "You have to complete the registration of 12th class students before 2022.",
        //       fileName: "Exam-details.pdf",
        //       imageProvider: const AssetImage(
        //           'assets/class12.png'), // Pass your image here
        //     ),
        //   ),
        // );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.campaign_outlined, color: Colors.blue)),
          title: Text(
            noticeTitle,
            maxLines: 1, // Set max lines to 1 to keep it in a single line
            overflow: TextOverflow
                .ellipsis, // Show ellipsis (...) if the text overflows
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width *
                  0.045, // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.withOpacity(0.1)),
                child: Text(date, style: const TextStyle(color: Colors.blue))),
          ),
          trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue.withOpacity(0.1)),
              child: Text(time, style: const TextStyle(color: Colors.blue))),
          // trailing: Text(time),
        ),
      ),
    );
  }
}
