import 'package:flutter/material.dart';
import 'package:school_app/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // This ensures the page is scrollable when the keyboard appears
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top spacer
                    SizedBox(height: 30),
                    // Create Header
                    Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'your account',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 40),
                    // Email Input
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Phone Number Input
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_outlined),
                        labelText: 'phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Input with Toggle Visibility
                    TextField(
                      obscureText: _isPasswordObscured,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                        labelText: 'password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Confirm Password Input with Toggle Visibility
                    TextField(
                      obscureText: _isConfirmPasswordObscured,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordObscured =
                                  !_isConfirmPasswordObscured;
                            });
                          },
                        ),
                        labelText: 'confirm password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Register Button
                    SizedBox(
                      width: double.infinity, // Full width button
                      child: ElevatedButton(
                        onPressed: () {
                          // Add registration functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Login Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.grey[600]),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login here',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Bottom spacer
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
