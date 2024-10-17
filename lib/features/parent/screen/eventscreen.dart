import 'package:flutter/material.dart';
import 'package:school_app/features/parent/widgets/eventcard.dart'
    as event_card;

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const SingleChildScrollView(
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
                imageProvider: AssetImage('assets/images/event.png'),
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
              event_card.EventCard(
                eventTitle: "Cycle competition",
                eventDescription:
                    "National sports day will be conducted in our school...",
                date: "15 - 06 - 24",
                time: "09:00 am",
                imageProvider: AssetImage('assets/images/event2.png'),
              ),
              event_card.EventCard(
                eventTitle: "Sports day",
                eventDescription:
                    "National sports day will be conducted in our school...",
                date: "15 - 06 - 24",
                time: "09:00 am",
                imageProvider: AssetImage('assets/images/event3.png'),
              ),
              event_card.EventCard(
                eventTitle: "Sports day",
                eventDescription:
                    "National sports day will be conducted in our school...",
                date: "15 - 06 - 24",
                time: "09:00 am",
                imageProvider: AssetImage('assets/images/event4.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

