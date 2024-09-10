import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:school_app/screens/home.dart';
import 'package:school_app/screens/register.dart';
import 'package:school_app/widgets/custom_button.dart';
import 'package:school_app/widgets/custom_textfield.dart'; // Add this import for TapGestureRecognizer

class LoginPage extends StatelessWidget {
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
                      iconData: Icon(Icons.person_outline),
                      hintText: "Username",
                    ),
                    const SizedBox(height: 20),
                    CustomTextfield(
                      iconData: Icon(Icons.lock_outline),
                      isPasswordField: true,
                      hintText: "Password",
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      text: "Login",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                            children: [
                              TextSpan(
                                text: 'Register here',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                    // Username Input
                    // _buildTextField(
                    //   context,
                    //   icon: Icons.person_outline,
                    //   label: 'username',
                    //   obscureText: false,
                    // ),
                    // SizedBox(height: 20),
                    // _buildTextField(
                    //   context,
                    //   icon: Icons.lock_outline,
                    //   label: 'password',
                    //   obscureText: _isObscured,
                    //   toggleVisibility: () {
                    //     setState(() {
                    //       _isObscured = !_isObscured;
                    //     });
                    //   },
                    // ),

                    // Login Button
                    // SizedBox(
                    //   width: double.infinity, // Full width button
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => HomePage(),
                    //         ),
                    //       );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.black,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    //       padding: EdgeInsets.symmetric(vertical: 15),
                    //     ),
                    //     child: Text(
                    //       'Login',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Register Link
                    // Center(
                    // child: RichText(
                    //   text: TextSpan(
                    //     text: "Don't have an account? ",
                    //     style: TextStyle(color: Colors.grey[600]),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //         text: 'Register here',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => RegisterPage(),
                    //       ),
                    //     );
                    //   },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
