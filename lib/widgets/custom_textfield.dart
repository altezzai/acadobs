import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextInputType? keyBoardtype;
  final ValueNotifier<bool> isObscure;
  final bool isPasswordField;
  final Icon? iconData;
  final TextStyle? hintStyle; // Add hintStyle parameter

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    this.keyBoardtype,
    this.isPasswordField = false,
    this.hintStyle, // Initialize hintStyle
  }) : isObscure = ValueNotifier<bool>(isPasswordField);

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
          obscureText: isPasswordField ? isObscure.value : false,
          keyboardType: keyBoardtype,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            isDense: true,
            prefixIcon: iconData,
            hintText: hintText,
            hintStyle: hintStyle ?? // Apply custom hintStyle if provided
                TextStyle(
                    fontSize: 14.0, color: Colors.grey), // Default hint style
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
      },
    );
  }
}
