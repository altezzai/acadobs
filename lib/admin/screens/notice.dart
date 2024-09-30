import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/add_event.dart';
import 'package:school_app/admin/screens/add_notice.dart';
import 'package:school_app/admin/widgets/custom_button.dart';

class NoticeEventPage extends StatefulWidget {
  @override
  _NoticeEventPageState createState() => _NoticeEventPageState();
}

class _NoticeEventPageState extends State<NoticeEventPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Add Notice',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNoticePage()),
                      );
                    },
                  ),
                ),
                SizedBox(
                    width: screenWidth > 600
                        ? 32
                        : 16), // Adjust spacing for larger screens
                Expanded(
                  child: CustomButton(
                    text: 'Add Events',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEventPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Notices'),
              Tab(text: 'Events'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNoticesList(),
                _buildEventsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticesList() {
    return ListView(
      padding: EdgeInsets.all(8.0), // Add padding to the ListView
      children: [
        _buildNoticeItem('PTA meeting class XII', '15 - 06 - 24', '09:00 am'),
        _buildDivider('Yesterday'),
        _buildNoticeItem('PTA meeting class 09', '15 - 06 - 24', '09:00 am'),
        _buildNoticeItem('PTA meeting class 02', '15 - 06 - 24', '09:00 am'),
        _buildNoticeItem('PTA meeting class VII', '15 - 06 - 24', '09:00 am'),
        _buildNoticeItem('PTA meeting class XII', '15 - 06 - 24', '09:00 am'),
        _buildNoticeItem('PTA meeting class XII', '15 - 06 - 24', '09:00 am'),
      ],
    );
  }

  Widget _buildEventsList() {
    return ListView(
      padding: EdgeInsets.all(8.0), // Add padding to the ListView
      children: [
        _buildEventItem(
            'Sports day',
            'National sports day will be conducted in our school...',
            '15 - 06 - 24',
            'assets/sports_day.png'),
        _buildDivider('Yesterday'),
        _buildEventItem(
            'Cycle competition',
            'National sports day will be conducted in our school...',
            '15 - 06 - 24',
            'assets/cycle.png'),
        _buildEventItem(
            'Sports day',
            'National sports day will be conducted in our school...',
            '15 - 06 - 24',
            'assets/sports_day.png'),
        _buildEventItem(
            'Sports day',
            'National sports day will be conducted in our school...',
            '15 - 06 - 24',
            'assets/sports_day.png'),
      ],
    );
  }

  Widget _buildNoticeItem(String title, String date, String time) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.announcement, color: Colors.blue),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date, style: TextStyle(color: Colors.grey)),
        trailing: Text(
          time,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildEventItem(
      String title, String description, String date, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath,
              fit: BoxFit.cover, height: 150, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(description),
                SizedBox(height: 8),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text('View'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text, style: TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
