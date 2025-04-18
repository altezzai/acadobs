import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: 'Personal Informations',
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(47),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45,
                      child: Icon(
                        Icons.person_outline_sharp,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width * 4,
                  ),
                  Text(
                    'Change profile photo',
                    style: TextStyle(color: Color(0xff6F6F6F)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                labelText: 'Name',
                labelStyle: TextStyle(color: Color(0xff6F6F6F)),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(47),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ), // Black border
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Color(0xff6F6F6F)),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(47),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ), // Black border
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height * 50,
            ),
            CommonButton(
              onPressed: () {},
              widget: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
