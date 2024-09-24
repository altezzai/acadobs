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
  final ValueChanged<String>? onChanged; // Callback for text input

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    this.keyBoardtype,
    this.isPasswordField = false,
    this.hintStyle,
    this.textStyle, // Text style for the text input
    this.onTap, // Handle onTap event (for date picker, etc.)
    this.onChanged, // Handle text changes
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
            readOnly: onTap !=
                null, // Make the field read-only if onTap is provided (for date picker)
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              isDense: true,
              prefixIcon: iconData,
              hintText: hintText,
              hintStyle: hintStyle ??
                  const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ), // Default hint style
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: isPasswordField
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          isObscure.value = !isObscure.value;
                        },
                        icon: isObscure.value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
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
