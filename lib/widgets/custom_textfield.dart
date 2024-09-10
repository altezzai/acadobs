import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class CustomTextfield extends StatelessWidget {
  // final TextEditingController controller;
  final String hintText;
  final TextInputType? keyBoardtype;
  final ValueNotifier<bool> isObscure;
  final bool isPasswordField;
  final Icon? iconData;
  CustomTextfield(
      {super.key,
      // required this.controller,
      required this.hintText,
      required this.iconData,
      this.keyBoardtype,
      this.isPasswordField = false})
      : isObscure = ValueNotifier<bool>(isPasswordField);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isObscure,
        builder: (context, value, child) {
          return TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: blackColor),
            // controller: controller,
            obscureText: isPasswordField ? isObscure.value : false,
            keyboardType: keyBoardtype,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              isDense: true,
              prefixIcon: iconData,
              hintText: hintText,
              suffixIcon: isPasswordField
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          onPressed: () {
                            isObscure.value = !isObscure.value;
                          },
                          icon: isObscure.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    )
                  : null,
            ),
          );
        });
  }
}
