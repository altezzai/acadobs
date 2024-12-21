import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class NoteChatDetailPage extends StatefulWidget {
  final int noteId;
  // final String name;
  // final String subject;
  // final String imageUrl;

  NoteChatDetailPage({
    required this.noteId,
    // required this.name,
    // required this.subject,
    // required this.imageUrl,
  });

  @override
  State<NoteChatDetailPage> createState() => _NoteChatDetailPageState();
}

class _NoteChatDetailPageState extends State<NoteChatDetailPage> {
  @override
  void initState() {
    // context.read<StudentController>().getParentDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesController>().getNotesByNoteId(noteId: widget.noteId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage("${baseUrl}${Urls.parentPhotos}${widget.parent.fatherMotherPhoto??""}"),
            // ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   widget.parent.guardianFullName??"",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   widget.subject,
                //   style: TextStyle(color: Colors.grey, fontSize: 12),
                // ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Consumer<NotesController>(builder: (context, value, child) {
        final parentNote = value.parentNote;
        return value.isloading
            ? Center(
                child: Loading(
                color: Colors.grey,
              ))
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
                                "Note",
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
                                    '09/01/2001',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            parentNote?.data?.noteTitle ?? "",
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
                    SizedBox(height: 10),
                    //   _buildReply("shibu", "Why are you so mad?? don't you have any life",
                    //       'assets/angus.png'),
                    //  _buildReply("April Curtis", "What bro?", widget.parent.studentPhoto??""),

                    // Comment Input Field
                    Consumer<NotesController>(builder: (context, value, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value
                              .parentNote?.data?.ParentNoteStudents?.length,
                          itemBuilder: (context, index) {
                            final studentDetail = value.parentNote?.data
                                ?.ParentNoteStudents![index].student;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: InkWell(
                                onTap:() {
                                  
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(capitalizeEachWord(
                                      studentDetail?.fullName ?? "")),
                                ),
                              ),
                            );
                          });
                    }),
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
              );
      }),
    );
  }

  Widget _buildReply(String name, String message, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 20,
          ),
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
