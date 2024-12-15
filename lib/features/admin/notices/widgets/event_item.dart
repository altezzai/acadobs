import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String imagePath;

  const EventItem({
    required this.title,
    required this.description,
    required this.date,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imagePath,
              fit: BoxFit.cover, height: 150, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(date, style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text('View'),
            ),
          ),
        ],
      ),
    );
  }
}
