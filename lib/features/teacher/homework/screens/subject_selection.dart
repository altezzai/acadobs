import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';

class SubjectSelectionPage extends StatefulWidget {
  final TextEditingController subjectTextEditingController;

  SubjectSelectionPage({super.key, required this.subjectTextEditingController});

  @override
  State<SubjectSelectionPage> createState() => _SubjectSelectionPageState();
}

class _SubjectSelectionPageState extends State<SubjectSelectionPage> {
  late SubjectController subjectController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      subjectController = context.read<SubjectController>();
      subjectController.getSubjects();
      // subjectController.clearSelection();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Subject")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              // Consumer<SubjectController>(
              //     builder: (context, subjectProvider, child) {
              //   return subjectProvider.isloading
              //       ? Column(
              //           children: [
              //             SizedBox(
              //               height: Responsive.height * 35,
              //             ),
              //             Loading(),
              //           ],
              //         )
              //       : ListView.builder(
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: subjectProvider.subjects.length,
              //           itemBuilder: (context, index) {
              //             final subject = subjectProvider.subjects[index];
              //             return Padding(
              //               padding: EdgeInsets.only(
              //                 bottom:
              //                     index == subjectProvider.subjects.length - 1
              //                         ? 80.0
              //                         : 0.0, // Extra space for last item
              //               ),
              //               child: SubjectSelectionCard(
              //                 subjectName:
              //                     capitalizeEachWord(subject.subject ?? ""),
              //                 subjectId: subject.id ?? 0,
              //                 isSelected: subjectProvider.selectedSubjectId ==
              //                     subject.id,
              //                 onSelect: (bool? selected) {
              //                   if (selected == true) {
              //                     subjectProvider
              //                         .selectSubject(subject.id ?? 0);
              //                     widget.subjectTextEditingController.text =
              //                         subject.subject ?? "";
              //                   }
              //                 },
              //               ),
              //             );
              //           },
              //         );
              // }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CommonButton(
            onPressed: () {
              Navigator.pop(context);
            },
            widget: Text("Select")),
      ),
    );
  }
}
