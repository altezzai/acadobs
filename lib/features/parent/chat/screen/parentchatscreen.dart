import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class ParentNoteScreen extends StatefulWidget {
  final int studentId;

  const ParentNoteScreen({super.key, required this.studentId});

  @override
  State<ParentNoteScreen> createState() => _ParentNoteScreenState();
}

class _ParentNoteScreenState extends State<ParentNoteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<NotesController>()
          .getNotesByStudentId(studentId: widget.studentId);
    });
  }

// import 'package:go_router/go_router.dart';
// import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
// import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/parent/chat/screen/parentchatdetailedscreen.dart';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chat',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: Responsive.height * 2),
            _buildSearchBar(),
            Expanded(
              child:
                  Consumer<NotesController>(builder: (context, controller, _) {
                return controller.isloading
                    ? Center(child: const Loading(color: Colors.grey))
                    : _buildNotesList(controller);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search for Teachers',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildNotesList(NotesController controller) {
    return ListView.builder(
      itemCount: controller.parentNoteStudent.length,
      itemBuilder: (context, index) {
        final teacherNote = controller.parentNoteStudent[index];
        return _buildTeacherTile(
          context,
          isNewMessage: teacherNote.viewed == 0,
          name: teacherNote.teacherName ?? "",
          subject: 'Subject',
          imageUrl:
              "${baseUrl}${Urls.teacherPhotos}${teacherNote.teacherProfilePhoto}",
          onTap: () async {
            controller.markParentNoteAsViewed(
              context: context,
              studentId: widget.studentId,
              parentNoteId: teacherNote.id ?? 0,
              teacherNote: teacherNote,
            );
            context.pushNamed(AppRouteConst.parentNoteDetailRouteName,
                extra: teacherNote);
          },
        );
      },
    );
  }

  Widget _buildTeacherTile(
    BuildContext context, {
    required String name,
    required String subject,
    required String imageUrl,
    required VoidCallback onTap,
    bool isNewMessage = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subject),
      trailing: isNewMessage
          ? Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                const Text(
                  '1', // Replace with dynamic count if available
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : null,
      onTap: onTap,
    );
  }
}
