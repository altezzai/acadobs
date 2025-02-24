import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
// import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
// import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    context.read<NoticeController>().getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomAppbar(
                  title: "Events",
                  isBackButton: false,
                  isProfileIcon: false,
                 ),
              Consumer<NoticeController>(builder: (context, controller, child) {
                final now = DateTime.now();

                // Categorize events
                final upcomingEvents = controller.events
                    .where((event) =>
                        DateTime.parse(event.eventDate.toString()).isAfter(now))
                    .toList();

                final latestEvents = controller.events
                    .where((event) =>
                        DateTime.parse(event.eventDate.toString())
                            .isAfter(now.subtract(const Duration(days: 1))) &&
                        DateTime.parse(event.eventDate.toString())
                            .isBefore(now))
                    .toList();

                final previousEvents = controller.events
                    .where((event) => DateTime.parse(event.eventDate.toString())
                        .isBefore(now.subtract(const Duration(days: 1))))
                    .toList();

                // Sort events
                upcomingEvents.sort((a, b) =>
                    DateTime.parse(a.eventDate.toString())
                        .compareTo(DateTime.parse(b.eventDate.toString())));
                latestEvents.sort((a, b) =>
                    DateTime.parse(b.eventDate.toString())
                        .compareTo(DateTime.parse(a.eventDate.toString())));
                previousEvents.sort((a, b) =>
                    DateTime.parse(b.eventDate.toString())
                        .compareTo(DateTime.parse(a.eventDate.toString())));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Events Section
                    const Text(
                      "Upcoming",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    upcomingEvents.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: upcomingEvents.length,
                            itemBuilder: (context, index) {
                              final event = upcomingEvents[index];
                              return EventCard(
                                onTap: () {
                                  context.pushNamed(
                                      AppRouteConst.EventDetailedPageRouteName,
                                      extra: EventDetailArguments(
                                        event: event,
                                        userType: UserType.parent,
                                      ));
                                },
                                bottomRadius: 16,
                                topRadius: 16,
                                eventDescription: event.description ?? "",
                                eventTitle: event.title ?? "",
                                date: DateFormatter.formatDateString(
                                    event.eventDate.toString()),
                                time: TimeFormatter.formatTimeFromString(
                                    event.createdAt.toString()),
                                imageProvider:
                                    "${baseUrl}${Urls.eventPhotos}${event.images![0].imagePath}",
                              );
                            },
                          )
                        : const Text("No upcoming events available."),
                    SizedBox(height: Responsive.height * 2),

                    // Latest Events Section
                    const Text(
                      "Latest",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    latestEvents.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: latestEvents.length,
                            itemBuilder: (context, index) {
                              final event = latestEvents[index];
                              return EventCard(
                                onTap: () {
                                  context.pushNamed(
                                    AppRouteConst.EventDetailedPageRouteName,
                                    extra: EventDetailArguments(
                                      event: event,
                                      userType: UserType.parent,
                                    ),
                                  );
                                },
                                bottomRadius: 16,
                                topRadius: 16,
                                eventDescription: event.description ?? "",
                                eventTitle: event.title ?? "",
                                date: DateFormatter.formatDateString(
                                    event.eventDate.toString()),
                                time: TimeFormatter.formatTimeFromString(
                                    event.createdAt.toString()),
                                imageProvider:
                                    "${baseUrl}${Urls.eventPhotos}${event.images![0].imagePath}",
                              );
                            },
                          )
                        : const Text("No latest events available."),
                    SizedBox(height: Responsive.height * 2),

                    // Previous Events Section
                    const Text(
                      "Previous",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    previousEvents.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: previousEvents.length,
                            itemBuilder: (context, index) {
                              final event = previousEvents[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: EventCard(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.EventDetailedPageRouteName,
                                      extra: EventDetailArguments(
                                        event: event,
                                        userType: UserType.parent,
                                      ),
                                    );
                                  },
                                  bottomRadius: 16,
                                  topRadius: 16,
                                  eventDescription: event.description ?? "",
                                  eventTitle: event.title ?? "",
                                  date: DateFormatter.formatDateString(
                                      event.eventDate.toString()),
                                  time: TimeFormatter.formatTimeFromString(
                                      event.createdAt.toString()),
                                  imageProvider:
                                      "${baseUrl}${Urls.eventPhotos}${event.images![0].imagePath}",
                                ),
                              );
                            },
                          )
                        : const Text("No previous events available."),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
