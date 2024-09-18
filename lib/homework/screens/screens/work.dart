import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/homework/screens/screens/widgets/custom_container.dart';
// import 'package:school_app/homework/screens/screens/widgets/custom_dropdown.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';

class HomeWork extends StatelessWidget {
  const HomeWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Center(
          child: Text(
            'Add Homework',
            style:
                textThemeData.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Responsive.height * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainer(
                leadingIcon: Icons.school,
                text: 'Class',
                trailingIcon: Icons.keyboard_arrow_down,
                width: Responsive.width * 3,
              ),
              CustomContainer(
                leadingIcon: Icons.abc,
                text: 'Division',
                trailingIcon: Icons.keyboard_arrow_down,
                width: Responsive.width * 3,
              )
            ],
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
            child: Column(
              children: [
                CustomContainer(
                  leadingIcon: Icons.person,
                  text: 'Select Student',
                  trailingIcon: Icons.keyboard_arrow_down,
                  width: Responsive.width * 38,
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                CustomContainer(
                  leadingIcon: Icons.note_outlined,
                  text: 'Select Subject',
                  trailingIcon: Icons.keyboard_arrow_down,
                  width: Responsive.width * 38,
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.width * 5,
                    ),
                    Text(
                      'Start date',
                      style: textThemeData.bodyMedium!.copyWith(fontSize: 19),
                    ),
                    SizedBox(
                      width: Responsive.width * 18,
                    ),
                    Text(
                      'End date',
                      style: textThemeData.bodyMedium!.copyWith(fontSize: 19),
                    )
                  ],
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _customContainer(text: 'mm/dd/yyyy'),
                    _customContainer(text: 'mm/dd/yyyy'),
                  ],
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.width * 4,
                    ),
                    Text(
                      'Homework details',
                      style: textThemeData.bodyMedium!.copyWith(fontSize: 19),
                    ),
                  ],
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                _customContainer(text: 'Title', icon: Icons.text_fields),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                SizedBox(
                  height: Responsive.height * 18,
                  child:
                      _customContainer(text: 'Description', icon: Icons.notes),
                ),
                SizedBox(
                  height: Responsive.height * 7,
                ),
                CustomButton(text: 'Submit', onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _customContainer({
    required String text,
    IconData icon = Icons.calendar_month,
  }) {
    return Container(
      padding: EdgeInsets.all(Responsive.height * 1.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
      child: Row(
        children: [
          SizedBox(
            width: Responsive.width * 2,
          ),
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: Responsive.width * 2,
          ),
          Text(
            text,
            style: TextStyle(color: Color(0xff6F6F6F), fontSize: 16),
          ),
          SizedBox(
            width: Responsive.width * 1,
          ),
        ],
      ),
    );
  }
}
