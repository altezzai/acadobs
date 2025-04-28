import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/route_constants.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/features/superadmin/presentation/screens/generic_list_screen.dart';
import 'package:school_app/features/superadmin/presentation/widgets/custom_tile_widget.dart';
import 'package:school_app/features/superadmin/schools/controller/school_controller.dart';

class SchoolsListScreen extends StatefulWidget {
  const SchoolsListScreen({super.key});

  @override
  State<SchoolsListScreen> createState() => _SchoolsListScreenState();
}

class _SchoolsListScreenState extends State<SchoolsListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final schoolController =
          Provider.of<SchoolController>(context, listen: false);
      schoolController.getAllSchools();
    });
  }

  void _scrollListener() {
    final schoolController =
        Provider.of<SchoolController>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      print('Scrolled near bottom, loading more...');
      schoolController.getAllSchools(loadMore: true);
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
  Widget build(BuildContext context) {
    return Consumer<SchoolController>(
      builder: (context, controller, child) {
        return GenericListScreen(
          title: 'Schools List',
          buttonText: 'School',
          onAddTap: () {
            context.pushNamed(RouteConstants.addSchool, extra: false);
          },
          isLoading: controller.isLoading,
          isLoadingMore: controller.isLoadingMore,
          scrollController: _scrollController,
          items: controller.schools,
          itemBuilder: (school) => CustomTileWidget(
            name: school.name,
            subtitle: school.email,
            onTap: () {
              // Handle tile tap
            },
            onDelete: () => showConfirmationDialog(
                context: context,
                title: "Delete School?",
                content: "Are you sure you want to delete this school?",
                onConfirm: () {
                  controller.deleteSchool(context, schoolId: school.id);
                }),
            onEdit: () => context.pushNamed(
              RouteConstants.editSchool,
              extra: school,
            ),
          ),
        );
      },
    );
  }
}
