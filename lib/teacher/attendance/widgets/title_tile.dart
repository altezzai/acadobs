import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Icon(
                  icon,
                  color: blackColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18),
              )
            ],
          )),
    );
  }
}
