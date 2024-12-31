import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:school_app/base/utils/responsive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DutyPage(),
    );
  }
}

class DutyPage extends StatefulWidget {
  @override
  _DutyPageState createState() => _DutyPageState();
}

class _DutyPageState extends State<DutyPage> {
  int _rating = 3; // Initial rating value

  // Build the star rating widget
  Widget _buildRatingStars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1; // Update rating based on the clicked star
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          '12th class.....',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 12th Class Header
                    Center(
                      child: Container(
                        width: double.infinity, // Full width
                        height: 200, // Increase height
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center vertically
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Center horizontally
                          children: [
                            Text(
                              'XII',
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Responsive.height * 2),
                    // Registration Information
                    Text(
                      '12th class New student Registration of 2024',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You have to complete the registration of 12th class students before 2022',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: Responsive.height * 2),
                    // Date Information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('Start date'),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('01/07/2024'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('End date'),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('01/07/2024'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height * 2),
                    // Feedback Section
                    Container(
                      padding: EdgeInsets.all(
                          16.0), // Adds padding inside the container
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Set the background color to white
                        borderRadius:
                            BorderRadius.circular(12.0), // Add rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.3), // Shadow color with some transparency
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 5, // Blur radius for the shadow
                            offset:
                                Offset(0, 3), // Offset (x, y) for the shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/profile_image.png'), // Replace with your profile image asset
                          ),
                          SizedBox(width: 16), // Space between avatar and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Joseph Christ.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        16.0, // Adjust font size if needed
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Rating Bar
                                RatingBar.builder(
                                  initialRating: 3, // Initial rating value
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true, // Allows half ratings
                                  itemCount: 5, // Number of stars
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors
                                        .amber, // Color for the filled stars
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(
                                        rating); // Update or use the new rating value
                                  },
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Improve your handwriting',
                                  style: TextStyle(
                                    color: Colors
                                        .black54, // Lighter text for the comment
                                    fontSize:
                                        14.0, // Adjust font size if needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.height * 2),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                                'assets/profile_image.png'), // Replace with your profile image asset
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Write a reply',
                                hintStyle: TextStyle(
                                  color: Colors
                                      .grey, // Change this color to your desired hint text color
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.black),
                            onPressed: () {
                              // Action for sending the reply
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Mark as Completed Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Action when the button is pressed
                        },
                        child: Text(
                          'Mark as Completed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
