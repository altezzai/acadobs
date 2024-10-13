import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButton;
  final bool isProfileIcon;
  final String title;
  final VoidCallback? onTap; // Optional onTap callback for the back button

  const CustomAppbar({
    super.key,
    this.isBackButton = true,
    this.isProfileIcon = true,
    required this.title, // Title for the app bar
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.height * 5),
      child: Row(
        children: [
          // Left Icon (Back Button)
          isBackButton
              ? GestureDetector(
                  onTap: onTap,
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFFD9D9D9),
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                )
              : const SizedBox(width: 48), // Empty space if no back button

          // Title in the Center
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
            ),
          ),

          // Right Icon (Profile Icon)
          isProfileIcon
              ? const CircleAvatar(
                  backgroundImage: AssetImage('assets/admin.png'),
                )
              : const SizedBox(width: 48), // Empty space if no profile icon
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      Responsive.height * 10); // Set height as per your requirement
}
