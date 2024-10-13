import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class StarContainer extends StatelessWidget {
  final String name;
  final String rollNo;
  const StarContainer({super.key, required this.name, required this.rollNo,});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xffCCCCCC)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: Responsive.height * 1,
          ),
          Row(
            children: [
              SizedBox(
                width: Responsive.width * 2,
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xffF4F4F4),
                child: Text(rollNo, style: textThemeData.labelSmall),
              ),
              SizedBox(
                width: Responsive.width * 3,
              ),
              Text(
                name,
                style: textThemeData.labelSmall!.copyWith(
                  color: Colors.black,
                ),
              )
            ],
          ),
          SizedBox(
            height: Responsive.height * 1,
          ),
          Container(
            width: Responsive.width * 95,
            height: Responsive.height * .08,
            color: const Color(0xffCCCCCC),
          ),
          Row(
            children: [
              SizedBox(
                width: Responsive.width * 4,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding:
                    EdgeInsets.symmetric(horizontal: Responsive.width * 1),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 5,
                ),
                onRatingUpdate: (rating) {
                  print('Rating is: $rating');
                },
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(Responsive.width * 5),
                decoration: const BoxDecoration(
                  color: Color(0xffF3F3F3),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(Icons.chat_outlined),
              )
            ],
          ),
        ],
      ),
    );
  }
}
