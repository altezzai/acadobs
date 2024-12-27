import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_student_model.dart';

class ChatDetailPage extends StatefulWidget {
  final NoteData studentNote;
  // final int teacherId;

  ChatDetailPage({
    super.key,
    required this.studentNote,
    //  required this.teacherId
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  // ChatDetailPage({
  final TextEditingController _chatController = TextEditingController();
  late NotesController notesController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notesController = context.read<NotesController>();
      notesController.getAllParentChats(
        
          parentNoteId: widget.studentNote.id);
    });
    super.initState();
  }

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
                      "${baseUrl}${Urls.teacherPhotos}${widget.studentNote.teacherProfilePhoto ?? ""}",
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
                  widget.studentNote.teacherName ?? "",
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
      body:
          Consumer<NotesController>(builder: (context, chatController, child) {
        return chatController.isloadingForChats
            ? Column(
                children: [
                  SizedBox(
                    height: Responsive.height * 40,
                  ),
                  Loading(
                    color: Colors.grey,
                  ),
                ],
              )
            : Padding(
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
                                    DateFormatter.formatDateString(widget
                                        .studentNote.createdAt
                                        .toString()),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.studentNote.noteTitle ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.studentNote.noteContent ?? "",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Replies Section
                    Text(
                      "Replies",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // Consumer<NotesController>(
                    //     builder: (context, chatController, child) {
                    // if (chatController.isloading) {
                    //   // Display a loading indicator while fetching data
                      // return Column(
                      //   children: [
                      //     SizedBox(height: Responsive.height * 30),
                      //     Loading(color: Colors.grey),
                      //   ],
                      // );
                    // }
                    // else
                    //if (chatController.parentChat.isEmpty) {
                    //   // Display a fallback message when there are no chats
                    //   return Center(
                    //     child: Text(
                    //       "No chats available.",
                    //       style: TextStyle(color: Colors.grey),
                    //     ),
                    //   );
                    // }

                    // Render the list only when it's safe to access the parentChat list
                    // else {
                    // return

                    chatController.parentChat == 0
                        ? Text("Start Chat")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: chatController.parentChat.length,
                            itemBuilder: (context, index) {
                              final parentChat =
                                  chatController.parentChat[index];
                              return _buildReply(
                                  "You", parentChat.message ?? "No message");
                              // },
                              // );
                            }
                            // },
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
                            controller: _chatController,
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
                        Consumer<NotesController>(
                            builder: (context, value, child) {
                          final teacherReceiverId =
                              value.parentChat[0].receiverId ?? 0;
                          return CircleAvatar(
                            backgroundColor: Colors.black,
                            child: IconButton(
                              icon: Icon(Icons.send, color: Colors.white),
                              onPressed: () async {
                                // _chatController.clear();
                                log("TeacherChatId = ${teacherReceiverId}");
                                context
                                    .read<NotesController>()
                                    .sendParentNoteChatParent(
                                        isTeacher: false,
                                        parentNoteId:
                                            widget.studentNote.id,
                                        receiverId: teacherReceiverId,
                                        message: _chatController.text,
                                        senderRole: "student");
                                _chatController.clear();
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildReply(
    String name,
    String message,
    //  String imageUrl
  ) {
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
