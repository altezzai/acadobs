import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextInputType? keyBoardtype;
  final ValueNotifier<bool> isObscure;
  final bool isPasswordField;
  final Icon? iconData;
  final TextStyle? hintStyle;
  final TextStyle? textStyle; // Text style for the input text
  final TextStyle? errorStyle; // New parameter for error message style
  final VoidCallback? onTap; // Callback function for onTap
  final ValueChanged<String>? onChanged; // Callback for text input
  final FormFieldValidator<String>? validator; // Validator for input

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    this.keyBoardtype,
    this.isPasswordField = false,
    this.hintStyle,
    this.textStyle, // Text style for the text input
    this.errorStyle, // Added parameter for error message style
    this.onTap, // Handle onTap event (for date picker, etc.)
    this.onChanged, // Handle text changes
    this.validator, // Validator function
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
                      fontSize: 14.0,
                    ), // Default text style
            obscureText: isPasswordField ? isObscure.value : false,
            keyboardType: keyBoardtype,
            onChanged: onChanged, // Call the onChanged callback
            validator: validator, // Apply the validator
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
              errorStyle: errorStyle ?? // Use the new errorStyle parameter
                  const TextStyle(
                    fontSize: 12.0, // Smaller font size for error messages
                    color: Colors.red, // Optional: change color if needed
                  ),
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
