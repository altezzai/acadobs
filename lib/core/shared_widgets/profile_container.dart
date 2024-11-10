import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';

class ProfileContainer extends StatelessWidget {
  final String imagePath;
  final String? description;
  final String name;
  const ProfileContainer(
      {super.key,
      required this.imagePath,
      this.description,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height * 0.09;
    final double avatarRadius = 34.0; // Adjust the avatar size as needed

    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior:
              Clip.none, // Allows the avatar to overflow the container
          children: [
            // Main container
            Container(
              height: containerHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              bottom: -avatarRadius * 0.5,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: whiteColor, width: 2)),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
            ),
            Positioned(
              bottom: -avatarRadius * 1.5,
              child: Text(
                "$name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Responsive.height * 7,
        ),
        Text(
          "$description",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7C7C7C)),
        ),
        SizedBox(
          height: Responsive.height * 1,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          // height: containerHeight,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _numberColumn(number: "25", subText: "Present"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 26),
                width: 3,
                color: Color(0xFFF4F4F4),
              ),
              _numberColumn(number: "25", subText: "Late"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 26),
                width: 3,
                color: Color(0xFFF4F4F4),
              ),
              _numberColumn(number: "25", subText: "Absent"),
            ],
          ),
        )
      ],
    );
  }

  Widget _numberColumn({
    required String number,
    required String subText,
  }) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              number,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              subText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7C7C7C)),
            ),
          ],
        ),
      ],
    );
  }
}
