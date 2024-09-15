import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextInputType? keyBoardtype;
  final ValueNotifier<bool> isObscure;
  final bool isPasswordField;
  final Icon? iconData;
  final TextStyle? hintStyle;
  final TextStyle? textStyle; // Text style for the input text
  final VoidCallback? onTap; // Callback function for onTap
  final ValueChanged<String>? onChanged; // New onChanged callback

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    this.keyBoardtype,
    this.isPasswordField = false,
    this.hintStyle,
    this.textStyle, // New parameter for input text styling
    this.onTap, // Initialize onTap callback
    this.onChanged, // Initialize onChanged callback
  }) : isObscure = ValueNotifier<bool>(isPasswordField);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ValueListenableBuilder(
        valueListenable: isObscure,
        builder: (context, value, child) {
          return TextFormField(
            style: textStyle ??
                Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black87,
                    fontSize: 14.0), // Default text style
            obscureText: isPasswordField ? isObscure.value : false,
            keyboardType: keyBoardtype,
            onChanged: onChanged, // Call the onChanged callback
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              isDense: true,
              prefixIcon: iconData,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ), // Default hint style if not provided
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: isPasswordField
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          isObscure.value = !isObscure.value;
                        },
                        icon: isObscure.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
