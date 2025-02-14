import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // context
    //     .read<StudentIdController>()
    //     .getStudentsFromClassAndDivision(className: "8", section: "b");
    super.initState();
  }

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
              child: Form(
                key: _formKey,
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
                      onTap: null, // No tap event required for username input
                      validator: (value) => FormValidator.validateEmail(value),
                    ),
                    SizedBox(height: Responsive.height * 2),
                    CustomTextfield(
                      hintText: "Password",
                      iconData: Icon(Icons.lock_outline),
                      isPasswordField: true,
                      controller: passwordController,
                      onTap: null, // No tap event required for password input
                      validator: (value) =>
                          FormValidator.validatePassword(value),
                    ),
                    SizedBox(height: Responsive.height * 2),
                    Consumer<AuthController>(builder: (context, value, child) {
                      return CommonButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              context.read<AuthController>().login(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            } catch (e) {
                              // Handle any errors and show an error message
                              CustomSnackbar.show(context,
                                  message: "Failed to Login.Please try again",
                                  type: SnackbarType.failure);
                            }
                          } else {
                            // Highlight missing fields if the form is invalid
                            CustomSnackbar.show(context,
                                message: "Please complete all required fields",
                                type: SnackbarType.warning);
                          }
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
      ),
    );
  }
}
