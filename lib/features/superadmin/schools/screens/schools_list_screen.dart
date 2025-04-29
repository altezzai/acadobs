import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/route_constants.dart';
import 'package:school_app/base/utils/image_urls.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/features/superadmin/presentation/screens/generic_list_screen.dart';
import 'package:school_app/features/superadmin/presentation/widgets/custom_tile_widget.dart';
import 'package:school_app/features/superadmin/schools/controller/school_controller.dart';

class SchoolsListScreen extends StatefulWidget {
  const SchoolsListScreen({super.key});

  @override
  State<SchoolsListScreen> createState() => _SchoolsListScreenState();
}


class _SchoolsListScreenState extends State<SchoolsListScreen>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true; // 🔁 Preserve state on tab switch

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    // Fetch only once after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<SchoolController>(context, listen: false);
      controller.getAllSchools(); // ✅ Won't re-fetch if already done
    });
  }

  void _scrollListener() {
    final controller = Provider.of<SchoolController>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.getAllSchools(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SchoolController>(
      builder: (context, controller, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.getAllSchools(
                forceRefresh: true); // Pull to refresh (resets list)
          },
          child: GenericListScreen(
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
              isImageIcon: true,
              imageUrl: ImageUrls.imageBaseUrl +
                  ImageUrls.schoolLogos +
                  school.logo.toString(),
              name: school.name,
              subtitle: school.email,
              onTap: () {
                log("Tapped: ${school.name}");
              },
              onDelete: () => showConfirmationDialog(
                context: context,
                title: "Delete School?",
                content: "Are you sure you want to delete this school?",
                onConfirm: () {
                  controller.deleteSchool(context, schoolId: school.id);
                },
              ),
              onEdit: () => context.pushNamed(
                RouteConstants.editSchool,
                extra: school,
              ),
            ),
          ),
        );
      },
    );
  }
}
