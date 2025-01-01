import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';
import 'package:school_app/features/teacher/parent/model/latest_chat_model.dart';

class TeacherChatScreen extends StatefulWidget {
  final LatestChat latestChat;

  TeacherChatScreen({super.key, required this.latestChat});

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late NotesController notesController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController = context.read<NotesController>();
      notesController.getAllParentChats(
        parentNoteId: widget.latestChat.parentNoteId,
        forTeacherScreen: true,
        studentIdforChat: widget.latestChat.senderId,
      );
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          // widget.latestChat.parentName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Chat Messages Section
          Expanded(
            child: Consumer<NotesController>(
              builder: (context, chatController, child) {
                if (chatController.isloadingForChats) {
                  return Center(child: Loading(color: Colors.black));
                }
                _scrollToBottom();
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: chatController.parentChat.length,
                  itemBuilder: (context, index) {
                    final parentChat = chatController.parentChat[index];
                    final isYourChat = parentChat.senderRole == "teacher";
                    return _buildChatBubble(
                      name: parentChat.senderRole == "student" ? "" : "You",
                      message: parentChat.message ?? "",
                      isYourChat: isYourChat,
                      timestamp: DateFormatter.formatDateString(
                          parentChat.createdAt.toString()),
                    );
                  },
                );
              },
            ),
          ),

          // Message Input Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    final message = _chatController.text.trim();
                    if (message.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Message cannot be empty')),
                      );
                      return;
                    }

                    final receiverId = notesController.latestChats[0].senderId;
                    // if (receiverId == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Receiver ID not found')),
                    //   );
                    //   return;
                    // }

                    // notesController.sendParentNoteChatTeacher(
                    //   parentNoteId: widget.latestChat.parentNoteId,
                    //   receiverId: receiverId,
                    //   message: message,
                    //   senderRole: "teacher",
                    // );
                    _chatController.clear();
                    _scrollToBottom();
                  },
                  backgroundColor: Colors.black,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required String name,
    required String message,
    required bool isYourChat,
    required String? timestamp,
  }) {
    return Align(
      alignment: isYourChat ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isYourChat ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: isYourChat ? Radius.circular(15) : Radius.zero,
            bottomRight: isYourChat ? Radius.zero : Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isYourChat)
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            const SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(
                color: isYourChat ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              timestamp ?? "",
              style: TextStyle(
                fontSize: 10,
                color: isYourChat ? Colors.white70 : Colors.grey[600],
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
