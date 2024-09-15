import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/home.dart';
import 'package:school_app/admin/screens/login.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 160),
                  Text('Create',
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text(
                    'your account',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 40),
                  CustomTextfield(
                    hintText: "email",
                    iconData: Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hintText: "Phone Number",
                    iconData: Icon(Icons.phone_outlined),
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    iconData: Icon(Icons.lock_outline),
                    isPasswordField: true,
                    hintText: "Password",
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    iconData: Icon(Icons.lock_outline),
                    isPasswordField: true,
                    hintText: "Confirm Password",
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      text: "Register",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHomePage(),
                          ),
                        );
                      }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.grey[600]),
                          children: [
                            TextSpan(
                              text: 'Login here',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                            )
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
