import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  final UserType userType;

  const EventDetailPage({
    Key? key,
    required this.event,
    required this.userType,
  }) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    // Construct full image URLs using your specified format
    final imageUrls = event.images?.map((e) {
          return "${baseUrl}${Urls.eventPhotos}${e.imagePath}";
        }).toList() ??
        [];

    return Scaffold(
      appBar: CommonAppBar(
        title: capitalizeEachWord(event.title ?? ""),
        isBackButton: true,
        actions: [
          if (widget.userType == UserType.admin) // Show for admin only
            Consumer<NoticeController>(
              builder: (context, eventController, child) {
                return CustomPopupMenu(
                  onEdit: () {
                    context.pushNamed(AppRouteConst.editEventRouteName,
                        extra: event);
                  },
                  onDelete: () {
                    showConfirmationDialog(
                        context: context,
                        title: "Delete Event?",
                        content: "Are you sure you want to delete this event?",
                        onConfirm: () {
                          eventController.deleteEvents(context,
                              eventId: event.eventId ?? 0);
                        });
                  },
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<NoticeController>(
            builder: (context, eventController, child) {
          if (eventController.isloading) {
            return Loading();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              if (imageUrls.isNotEmpty) ...[
                CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = imageUrls[index];
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _activeIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: _activeIndex,
                      count: imageUrls.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 8,
                        dotHeight: 8,
                        activeDotColor: Colors.black,
                        dotColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Center(
                  child: Text(
                    "No Images Available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      event.description ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: Responsive.height * 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Text(
                        event.eventDate.toString(),
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
