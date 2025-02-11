import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class CustomAppbar extends StatelessWidget {
  final bool isBackButton;
  final bool isProfileIcon;
  final String title;
  final double verticalPadding;
  final VoidCallback? onTap;

  const CustomAppbar({
    super.key,
    this.isBackButton = true,
    this.isProfileIcon = true,
    required this.title,
    this.onTap,
    this.verticalPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.height * verticalPadding,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button on the left
          if (isBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onTap,
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFD9D9D9),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                  ),
                ),
              ),
            ),

          // Centered title with ellipsis
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.width * 54, // Adjust max width if needed
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Adds "..." for long text
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
              ),
            ),
          ),

          // Profile icon on the right
          if (isProfileIcon)
            Align(
              alignment: Alignment.centerRight,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/admin.png'),
              ),
            ),
        ],
      ),
    );
  }
}
