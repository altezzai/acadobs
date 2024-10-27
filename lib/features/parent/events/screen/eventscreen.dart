import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart'
    as event_card;
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(
              AppRouteConst.ParentHomeRouteName,
            );
            // Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Events',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today Events Section
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              event_card.EventCard(
                eventTitle: "Sports day",
                eventDescription:
                    "National sports day will be conducted in our school...",
                date: "15 - 06 - 24",
                time: "09:00 am",
                imageProvider: AssetImage('assets/event.png'),
              ),
              SizedBox(height: 20),

              // Yesterday Events Section
              Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Consumer<NoticeController>(builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.events.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                      eventDescription: value.events[index].description ?? "",
                      eventTitle: value.events[index].title ?? "",
                      date: DateFormatter.formatDateString(
                          value.events[index].eventDate.toString()),
                      time: TimeFormatter.formatTimeFromString(
                          value.events[index].createdAt.toString()),
                      imageProvider: AssetImage("assets/event2.png"),
                    );
                  },
                );
              })
              // event_card.EventCard(
              //   eventTitle: "Cycle competition",
              //   eventDescription:
              //       "National sports day will be conducted in our school...",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              //   imageProvider: AssetImage('assets/event2.png'),
              // ),
              // event_card.EventCard(
              //   eventTitle: "Sports day",
              //   eventDescription:
              //       "National sports day will be conducted in our school...",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              //   imageProvider: AssetImage('assets/event3.png'),
              // ),
              // event_card.EventCard(
              //   eventTitle: "Sports day",
              //   eventDescription:
              //       "National sports day will be conducted in our school...",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              //   imageProvider: AssetImage('assets/event4.png'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
