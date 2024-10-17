import 'package:flutter/material.dart';

import 'package:school_app/features/parent/widgets/noticecard.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notices',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              NoticeCard(
                noticeTitle: "PTA meeting class XII",
                date: "15 - 06 - 24",
                time: "09:00 am",
              ),
              SizedBox(height: 20),

              // Yesterday Events Section
              Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              NoticeCard(
                noticeTitle: "PTA meeting class 09",
                date: "15 - 06 - 24",
                time: "09:00 am",
              ),
              NoticeCard(
                noticeTitle: "PTA meeting class 02",
                date: "15 - 06 - 24",
                time: "09:00 am",
              ),
              NoticeCard(
                noticeTitle: "PTA meeting class VII",
                date: "15 - 06 - 24",
                time: "09:00 am",
              ),
              NoticeCard(
                noticeTitle: "PTA meeting class X",
                date: "15 - 06 - 24",
                time: "09:00 am",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

