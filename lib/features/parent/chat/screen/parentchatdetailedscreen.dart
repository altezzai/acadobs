import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notesController = context.read<NotesController>();
      notesController.getAllParentChats(parentNoteId: widget.studentNote.id);
      notesController.getTeacherChatIdFromTeacherId(
          teacherId: widget.studentNote.teacherId ?? 0);
           if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
              width: 44,
              height: 44,
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
      body: Consumer<NotesController>(
        builder: (context, chatController, child) {
          return Column(
            children: [
              Expanded(
                child: chatController.isloadingForChats
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        reverse:
                            false, // To start from the bottom like WhatsApp
                        padding: const EdgeInsets.all(16.0),
                        itemCount: chatController.parentChat.length,
                        itemBuilder: (context, index) {
                          final parentChat = chatController.parentChat[index];
                          return _buildReply(
                            name: parentChat.senderRole == "teacher"
                                ? "Teacher"
                                : "You",
                            message: parentChat.message ?? "",
                            isYourChat: parentChat.senderRole == 'student'
                                ? false
                                : true,
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        maxLines: null, // Allows multiline input
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () async {
                          final message = _chatController.text.trim();
                          if (message.isNotEmpty) {
                            final teacherReceiverId =
                                context.read<NotesController>().teacherChatId;

                            context
                                .read<NotesController>()
                                .sendParentNoteChatParent(
                                  isTeacher: false,
                                  parentNoteId: widget.studentNote.id,
                                  receiverId: teacherReceiverId,
                                  message: message,
                                  senderRole: "student",
                                );
                            _chatController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
