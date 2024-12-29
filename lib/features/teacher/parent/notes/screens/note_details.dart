import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
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
  late NotesController notesController;
  @override
  void initState() {
    // context.read<StudentController>().getParentDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController = context.read<NotesController>();
      notesController.getLatestParentChats(parentNoteId: widget.noteId);
      notesController.getNotesByNoteId(noteId: widget.noteId);
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
                      return value.isloadingForChats
                          ? Column(
                              children: [
                                SizedBox(height: Responsive.height * 30),
                                Loading(color: Colors.grey),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.latestChats.length,
                              itemBuilder: (context, index) {
                                final latestChat = value.latestChats[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouteConst.teacherChatRouteName,
                                          extra: latestChat);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 14),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(latestChat.message ?? ""),
                                    ),
                                  ),
                                );
                              });
                    }),
                    Spacer(),
                  ],
                ),
              );
      }),
    );
  }
}
