import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class NoteChatDetailPage extends StatefulWidget {
  final int noteId;

  NoteChatDetailPage({required this.noteId});

  @override
  State<NoteChatDetailPage> createState() => _NoteChatDetailPageState();
}

class _NoteChatDetailPageState extends State<NoteChatDetailPage> {
  late NotesController notesController;

  @override
  void initState() {
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
      appBar: CommonAppBar(
        title: 'Note Details',
        isBackButton: true,
        actions: [
          Consumer<NotesController>(builder: (context, value, child) {
            return CustomPopupMenu(onEdit: () {
              context.pushNamed(AppRouteConst.editNoteRouteName,
                  extra: value.parentNote);
            }, onDelete: () {
              showConfirmationDialog(
                  context: context,
                  title: "Delete Note?",
                  content: "Are you sure you want to delete this note?",
                  onConfirm: () {
                    notesController.deleteNotes(context, noteId: widget.noteId);
                  });
            });
          })
        ],
      ),
      body: Consumer<NotesController>(
        builder: (context, value, child) {
          final parentNote = value.parentNote;
          return value.isloading
              ? Center(
                  child: Loading(color: Colors.grey),
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
                                        size: 14, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      DateFormatter.formatDateTime(
                                          parentNote?.data?.createdAt ??
                                              DateTime.now()),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              parentNote?.data?.noteTitle ??
                                  "No Title Available",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: Responsive.height * 1,
                            ),
                            Text(
                              parentNote?.data?.noteContent ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.height * 2),

                      // Replies Section
                      Text(
                        "Assigned Students",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // Latest Chat Messages
                      value.isloadingForChats
                          ? Center(child: Loading(color: Colors.grey))
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.parentNote?.data
                                        ?.ParentNoteStudents?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  // Safe access to ParentNoteStudents
                                  final student = value.parentNote?.data
                                      ?.ParentNoteStudents?[index].student;
                                  final studentName =
                                      student?.fullName ?? "Unknown Student";

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (index < value.latestChats.length) {
                                          context.pushNamed(
                                            AppRouteConst.teacherChatRouteName,
                                            extra: value.latestChats[index],
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 14),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              studentName,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
