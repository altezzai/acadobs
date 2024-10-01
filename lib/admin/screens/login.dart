import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/admin/screens/home.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';

import 'package:school_app/teacher/routes/app_route_const.dart';
// import 'package:school_app/teacher/home/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';

  // Function to handle login action
  void _login(BuildContext context) {
    if (_username == 'ajay' && _password == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } else if (_username == 'soorya' && _password == '1234') {
      context.pushReplacementNamed(AppRouteConst.homeRouteName);
    } else {
      // Show an error message if the login credentials are incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 270),
                  Text('Login',
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text(
                    'to your account',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 30),
                  CustomTextfield(
                    hintText: "Username",
                    iconData: Icon(Icons.person_outline),
                    onChanged: (value) {
                      setState(() {
                        _username = value; // Capture username input
                      });
                    },
                    onTap: null, // No tap event required for username input
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    hintText: "Password",
                    iconData: Icon(Icons.lock_outline),
                    isPasswordField: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value; // Capture password input
                      });
                    },
                    onTap: null, // No tap event required for password input
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () => _login(context),
                    text: "Login",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Login credentials are provied by  ",
                          style: TextStyle(color: Colors.grey[600]),
                          children: [
                            TextSpan(
                              text: 'Administration',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              // recognizer: TapGestureRecognizer()
                              //   ..onTap = () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => RegisterPage(),
                              //       ),
                              //     );
                              //   },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
