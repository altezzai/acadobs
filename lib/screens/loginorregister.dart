import 'package:flutter/material.dart';
import 'package:school_app/screens/login.dart';
import 'package:school_app/screens/register.dart';



class LoginOrRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double padding = constraints.maxWidth *
              0.1; // Adjust padding based on screen width
          final double buttonWidth = constraints.maxWidth *
              0.8; // Adjust button width based on screen width

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Centered Illustration Image (From assets)
                Container(
                  height: constraints.maxHeight *
                      0.4, // Adjust image height based on screen height
                  child: Image.asset(
                    'assets/school_1.png', // Image from assets folder
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                // Login Button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Register Button
                SizedBox(
                  width: buttonWidth,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to RegisterPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Colors.black, width: 2), // Border color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
