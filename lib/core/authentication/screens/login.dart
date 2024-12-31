import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/authentication/controller/auth_controller.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
// import 'package:school_app/teacher/home/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    context
        .read<StudentIdController>()
        .getStudentsFromClassAndDivision(className: "8", section: "b");
    super.initState();
  }

  // String _username = '';
  // String _password = '';

  // // Function to handle login action
  // void _login(BuildContext context) {
  //   if (_username == 'ajay' && _password == '1234') {
  //     context.pushReplacementNamed(AppRouteConst.bottomNavRouteName,
  //         extra: UserType.admin);
  //   } else if (_username == 'soorya' && _password == '1234') {
  //     context.pushReplacementNamed(AppRouteConst.bottomNavRouteName,
  //         extra: UserType.teacher);
  //   } else if (_username == 'manu' && _password == '1234') {
  //     // Navigate to ParentHomeScreen for parent login
  //     context.pushReplacementNamed(
  //       AppRouteConst.ParentHomeRouteName,
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid username or password')),
  //     );
  //   }
  // }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    controller: emailController,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _username = value; // Capture username input
                    //   });
                    // },
                    onTap: null, // No tap event required for username input
                  ),
                 SizedBox(height: Responsive.height * 2),
                  CustomTextfield(
                    hintText: "Password",
                    iconData: Icon(Icons.lock_outline),
                    isPasswordField: true,
                    controller: passwordController,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _password = value; // Capture password input
                    //   });
                    // },
                    onTap: null, // No tap event required for password input
                  ),
                  SizedBox(height: Responsive.height * 2),
                  // CustomButton(
                  //   onPressed: () {
                  //     context.read<AuthController>().login(
                  //         context: context,
                  //         email: emailController.text,
                  //         password: passwordController.text);
                  //   },
                  //   text: "Login",
                  // ),
                  Consumer<AuthController>(builder: (context, value, child) {
                    return CommonButton(
                      onPressed: () {
                        context.read<AuthController>().login(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      widget: value.isloading ? Loading() : Text('Login'),
                    );
                  }),
                  SizedBox(height: Responsive.height * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Login credentials are provided by  ",
                          style: TextStyle(color: Colors.grey[600]),
                          children: [
                            TextSpan(
                              text: 'Administration',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
