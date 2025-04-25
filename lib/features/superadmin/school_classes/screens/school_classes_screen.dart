import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/superadmin/presentation/screens/generic_list_screen.dart';
import 'package:school_app/features/superadmin/presentation/widgets/custom_tile_widget.dart';
import 'package:school_app/features/superadmin/school_classes/controller/school_classes_controller.dart';

class SchoolClassesScreen extends StatefulWidget {
  const SchoolClassesScreen({super.key});

  @override
  State<SchoolClassesScreen> createState() => _SchoolClassesScreenState();
}

class _SchoolClassesScreenState extends State<SchoolClassesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final schoolClassController =
          Provider.of<SchoolClassController>(context, listen: false);
      schoolClassController.getAllSchoolClasses();
    });
  }

  void _scrollListener() {
    final schoolClassController =
        Provider.of<SchoolClassController>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      print('Scrolled near bottom, loading more...');
      schoolClassController.getAllSchoolClasses(loadMore: true);
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
    return Consumer<SchoolClassController>(
      builder: (context, controller, child) {
        return GenericListScreen(
          title: 'Classes List',
          buttonText: 'Class',
          onAddTap: () {
            // Handle add school
          },
          isLoading: controller.isLoading,
          isLoadingMore: controller.isLoadingMore,
          scrollController: _scrollController,
          items: controller.schoolClasses,
          itemBuilder: (schoolClasses) => CustomTileWidget(
            name: schoolClasses.classname,
            subtitle: schoolClasses.division,
            onTap: () {
              // Handle tile tap
            },
          ),
        );
      },
    );
  }
}
