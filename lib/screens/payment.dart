import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Payments'),
      //   actions: [
      //     CircleAvatar(
      //       backgroundImage: AssetImage('assets/profile_image.png'),
      //     ),
      //     SizedBox(width: 10),
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add Payment'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.favorite),
                    label: Text('Add Donation'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Payments'),
              Tab(text: 'Donations'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPaymentsList(),
                _buildDonationsList(),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 4,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Duties'),
      //     BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Reports'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notification_important), label: 'Notice'),
      //     BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
      //   ],
      // ),
    );
  }

  Widget _buildPaymentsList() {
    return ListView(
      children: [
        _buildDateHeader('Today'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '09:00 am'),
        _buildDateHeader('Yesterday'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '08:00 am'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '09:00 am'),
      ],
    );
  }

  Widget _buildDonationsList() {
    return ListView(
      children: [
        _buildDateHeader('Today'),
        _buildPaymentItem('₹250', 'Muhammed Rafsal N', '09:00 am'),
        _buildDateHeader('Yesterday'),
        _buildPaymentItem('₹1500', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('₹700', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('300', 'Muhammed Rafsal N', '09:00 am'),
        _buildPaymentItem('₹2500', 'Muhammed Rafsal N', '08:00 am'),
        _buildPaymentItem('₹400', 'Muhammed Rafsal N', '09:00 am'),
      ],
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        date,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPaymentItem(String amount, String name, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[100],
        child: Icon(Icons.currency_rupee, color: Colors.green),
      ),
      title: Text(amount),
      subtitle: Text(name),
      trailing: Text(time),
    );
  }
}
