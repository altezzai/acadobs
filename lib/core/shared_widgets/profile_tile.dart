import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';

// ignore: must_be_immutable
class ProfileTile extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback? onPressed;
  final String? imageUrl;
  final IconData icon;
  const ProfileTile(
      {super.key,
      required this.name,
      required this.description,
      this.onPressed,
      this.icon = Icons.person_outline,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCCCCCC)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl ?? ""),
            radius: 25,
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
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Row(
                children: [
                  // Icon(
                  //   icon,
                  //   size: 18,
                  // ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: Color(0xFF7C7C7C),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Text(
              "View",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: blackColor, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
