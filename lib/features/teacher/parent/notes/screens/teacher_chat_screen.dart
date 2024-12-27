import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';
import 'package:school_app/features/teacher/parent/model/latest_chat_model.dart';

class TeacherChatScreen extends StatefulWidget {
  final LatestChat latestChat;
  // final NoteData studentNote;

  TeacherChatScreen({
    super.key,
    required this.latestChat,
    // required this.studentNote
  });

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  // ChatDetailPage({
  final TextEditingController _chatController = TextEditingController();
  late NotesController notesController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notesController = context.read<NotesController>();
      notesController.getAllParentChats(
          parentNoteId: widget.latestChat.parentNoteId ?? 0,
          forTeacherScreen: true,
          studentIdforChat: widget.latestChat.senderId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            // SizedBox(
            //   width: 44, // Diameter of the circle
            //   height: 44, // Diameter of the circle
            //   child: ClipOval(
            //     child: CachedNetworkImage(
            //       imageUrl:
            //           "${baseUrl}${Urls.teacherPhotos}${widget.studentNote.teacherProfilePhoto ?? ""}",
            //       placeholder: (context, url) => CircularProgressIndicator(),
            //       errorWidget: (context, url, error) => Icon(Icons.error),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(width: 10),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       widget.studentNote.teacherName ?? "",
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       "subject",
            //       style: TextStyle(color: Colors.grey, fontSize: 12),
            //     ),
            //   ],
            // ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Note Section
              // Container(
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.green[100],
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Icon(Icons.note, color: Colors.green),
              //           SizedBox(width: 8),
              //           Text(
              //             "Note:",
              //             style: TextStyle(
              //               color: Colors.green[900],
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           Spacer(),
              //           // Row(
              //           //   children: [
              //           //     Icon(Icons.calendar_today,
              //           //         size: 14, color: Colors.white),
              //           //     SizedBox(width: 5),
              //           //     Text(
              //           //       DateFormatter.formatDateString(
              //           //           widget.studentNote.createdAt.toString()),
              //           //       style: TextStyle(color: Colors.white),
              //           //     ),
              //           //   ],
              //           // ),
              //         ],
              //       ),
              //       SizedBox(height: 10),
              //       // Text(
              //       //   widget.studentNote.noteTitle ?? "",
              //       //   style: TextStyle(
              //       //       fontSize: 14,
              //       //       color: Colors.black,
              //       //       fontWeight: FontWeight.bold),
              //       // ),
              //       // Text(
              //       //   widget.studentNote.noteContent ?? "",
              //       //   style: TextStyle(fontSize: 14, color: Colors.black),
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20),

              // Replies Section
              Text(
                "Replies",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Consumer<NotesController>(
                  builder: (context, chatController, child) {
                return chatController.isloadingForChats
                    ? Column(
                        children: [
                          SizedBox(height: Responsive.height * 34),
                          Loading(color: Colors.grey),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: chatController.parentChat.length,
                        itemBuilder: (context, index) {
                          final parentChat = chatController.parentChat[index];
                          // if (parentChat.senderRole == 'student') {
                          //   return Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       _buildReply(
                          //           "studentname", parentChat.message ?? ""),
                          //     ],
                          //   );
                          // } else {
                          return _buildReply(
                              name: parentChat.senderRole == "student"
                                  ? "Student"
                                  : "You",
                              message: parentChat.message ?? "",
                              isYourChat: parentChat.senderRole == 'teacher'
                                  ? false
                                  : true);
                          // }
                        },
                      );
              }),
              // SizedBox(height: 10),
              // _buildReply("shibu", "Why are you so mad?? don't you have any life",
              //     'assets/angus.png'),
              // _buildReply("April Curtis", "What bro?", "imageUrl"),

              // Comment Input Field
              // Spacer(),
              // SizedBox(height: Responsive.height * 20),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
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
            Consumer<NotesController>(builder: (context, value, child) {
              final receiverId = value.latestChats[0].senderId;
              return CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    // _chatController.clear();
                    // log("TeacherChatId = ${teacherReceiverId}");
                    context.read<NotesController>().sendParentNoteChatTeacher(
                        parentNoteId: widget.latestChat.parentNoteId ?? 0,
                        receiverId: receiverId ?? 0,
                        message: _chatController.text,
                        senderRole: "teacher");
                    _chatController.clear();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildReply({
    required String name,
    required String message,
    required bool isYourChat,
  }
      //  String imageUrl
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage(imageUrl),
          //   radius: 20,
          // ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: isYourChat
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
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
