import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_student_model.dart';

class ChatDetailPage extends StatelessWidget {
  final NoteData studentNote;

  const ChatDetailPage({super.key, required this.studentNote});

  // ChatDetailPage({
  //   required this.studentNote
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            SizedBox(
              width: 44, // Diameter of the circle
              height: 44, // Diameter of the circle
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      "${baseUrl}${Urls.teacherPhotos}${studentNote.teacherProfilePhoto ?? ""}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentNote.teacherName ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "subject",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.note, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "Note:",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            DateFormatter.formatDateString(
                                studentNote.createdAt.toString()),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    studentNote.noteTitle ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentNote.noteContent ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Replies Section
            Text(
              "Replies",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 10),
            // _buildReply("shibu", "Why are you so mad?? don't you have any life",
            //     'assets/angus.png'),
            // _buildReply("April Curtis", "What bro?", "imageUrl"),

            // Comment Input Field
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Handle send comment
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReply(String name, String message, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage(imageUrl),
          //   radius: 20,
          // ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(message, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
