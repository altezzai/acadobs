import 'package:flutter/material.dart';

class NoticeItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const NoticeItem({
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.announcement, color: Colors.blue),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        subtitle:
            Text(date, style: TextStyle(color: Colors.grey, fontSize: 16)),
        trailing: Text(
          time,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
        ),
      ),
    );
  }
}
