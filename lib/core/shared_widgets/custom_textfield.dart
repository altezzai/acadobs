// import 'package:file_picker/file_picker.dart'; // Import the file picker package
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final String? label;
  final TextInputType? keyBoardtype;
  final ValueNotifier<bool> isObscure;
  final TextEditingController? controller;
  final bool isPasswordField;
  final Icon? iconData;
  final TextStyle? hintStyle;
  final TextStyle? textStyle; // Text style for the input text
  final TextStyle? errorStyle; // New parameter for error message style
  final VoidCallback? onTap; // Callback function for onTap
  final ValueChanged<String>? onChanged; // Callback for text input
  final FormFieldValidator<String>? validator; // Validator for input
  final bool enabled; // New enabled parameter
  final double borderRadius; // New parameter for border radius
  // Add controller parameter

  CustomTextfield({
    this.controller,
    super.key,
    this.hintText,
    this.label,
    required this.iconData,
    this.keyBoardtype,
    this.isPasswordField = false,
    this.hintStyle,
    this.textStyle, // Text style for the text input
    this.errorStyle, // Added parameter for error message style
    this.onTap, // Handle onTap event (for date picker, etc.)
    this.onChanged, // Handle text changes
    this.validator, // Validator function
    this.enabled = true, // By default, the field is enabled
    this.borderRadius = 8.0, // Default border radius
    // Make controller required
  }) : isObscure = ValueNotifier<bool>(isPasswordField);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(); // Call the onTap callback if it is provided
        }
      },
      child: ValueListenableBuilder(
        valueListenable: isObscure,
        builder: (context, value, child) {
          return TextFormField(
            // Pass the controller to the TextFormField
            controller: controller,
            style: textStyle ??
                Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black87,
                      fontSize: 14.0,
                    ), // Default text style
            obscureText: isPasswordField ? isObscure.value : false,
            keyboardType: keyBoardtype,
            onChanged: onChanged, // Call the onChanged callback
            validator: validator, // Apply the validator
            readOnly:
                onTap != null, // Make field read-only if onTap is provided
            enabled:
                enabled, // Use the enabled parameter to control field behavior
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
              isDense: true,
              prefixIcon: iconData,
              labelText: label,
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
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(
              //       borderRadius), // Use the borderRadius parameter
              //   borderSide: const BorderSide(color: Colors.grey),
              // ),
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
