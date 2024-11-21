import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class CustomAppbar extends StatelessWidget {
  final bool isBackButton;
  final bool isProfileIcon;
  final String title;
  final double verticalPadding;
  final VoidCallback? onTap; // Optional onTap callback for the back button

  const CustomAppbar(
      {super.key,
      this.isBackButton = true,
      this.isProfileIcon = true,
      required this.title, // Title for the app bar
      this.onTap,
      this.verticalPadding = 4});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.height * verticalPadding,
      ),
      child: Stack(
        alignment: Alignment.center, // Center the title
        children: [
          // Back button aligned to the left
          Align(
            alignment: Alignment.centerLeft,
            child: isBackButton
                ? GestureDetector(
                    onTap: onTap,
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFFD9D9D9),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                  )
                : const SizedBox(width: 48), // Placeholder to keep space
          ),

          // Title in the center
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
          ),

          // Profile icon aligned to the right
          Align(
            alignment: Alignment.centerRight,
            child: isProfileIcon
                ? const CircleAvatar(
                    backgroundImage: AssetImage('assets/admin.png'),
                  )
                : const SizedBox(width: 48), // Placeholder to keep space
          ),
        ],
      ),
    );
  }
}
