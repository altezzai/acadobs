import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const TitleTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: whiteColor),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFF4F4F4),
                radius: 24,
                child: Icon(
                  icon,
                  color: blackColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              )
            ],
          )),
    );
  }
}
