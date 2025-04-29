import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/route_constants.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/features/superadmin/presentation/screens/generic_list_screen.dart';
import 'package:school_app/features/superadmin/presentation/widgets/custom_tile_widget.dart';
import 'package:school_app/features/superadmin/school_subjects/controller/school_subjects_controller.dart';

class SchoolSubjectsScreen extends StatefulWidget {
  const SchoolSubjectsScreen({super.key});

  @override
  State<SchoolSubjectsScreen> createState() => _SchoolSubjectsScreenState();
}

class _SchoolSubjectsScreenState extends State<SchoolSubjectsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final schoolSubjectsController =
          Provider.of<SchoolSubjectsController>(context, listen: false);
      schoolSubjectsController.getAllSchoolSubjects();
    });
  }

  void _scrollListener() {
    final schoolSubjectsController =
        Provider.of<SchoolSubjectsController>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      print('Scrolled near bottom, loading more...');
      schoolSubjectsController.getAllSchoolSubjects(loadMore: true);
    } else if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 200) {
      print('Scrolled near top, loading more...');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolSubjectsController>(
      builder: (context, controller, child) {
        return GenericListScreen(
          title: 'Subjects List',
          buttonText: 'Subject',
          onAddTap: () {
            context.pushNamed(RouteConstants.addSubject, extra: false);
          },
          isLoading: controller.isLoading,
          isLoadingMore: controller.isLoadingMore,
          scrollController: _scrollController,
          items: controller.schoolSubjects,
          itemBuilder: (schoolSubject) => CustomTileWidget(
            name: schoolSubject.subjectName,
            subtitle: schoolSubject.classRange,
            onTap: () {
              // Handle tile tap
            },
            onEdit: () => context.pushNamed(
              RouteConstants.editSubject,
              extra: schoolSubject,
            ),
            onDelete: () => showConfirmationDialog(
              context: context,
              title: 'Delete Subject',
              content: 'Are you sure you want to delete this subject?',
              onConfirm: () {
                controller.deleteSubject(context, subjectId: schoolSubject.id);
              },
            ),
          ),
        );
      },
    );
  }
}
