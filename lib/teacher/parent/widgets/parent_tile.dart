import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class ParentTile extends StatelessWidget {
  final String name;
  final String studentName;
  const ParentTile({super.key, required this.name, required this.studentName,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/staff3.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: blackColor),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 18,
                  ),
                  Text(
                    studentName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Text(
              "View",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: blackColor, fontSize: 16),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}