import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/core/controller/loading_provider.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(builder: (context, value, index) {
      return ElevatedButton(
        onPressed: onPressed,
        child: value.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
              ),
      );
    });
  }
}
