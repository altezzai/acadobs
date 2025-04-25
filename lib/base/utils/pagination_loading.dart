import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';

class PaginationLoading extends StatelessWidget {
  const PaginationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: CircularProgressIndicator(
        color: greyColor,
      )),
    );
  }
}
