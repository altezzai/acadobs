import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi ,',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 48),
                    ),
                    Text(
                      'Vincent',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Color(0xff555555)),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset('assets/admin.png'),
                ),
              ],
            ),
            SizedBox(
              height: 180,
            ),
            _customContainer(color: Colors.green, text: 'Homework'),
            SizedBox(
              height: 10,
            ),
            _customContainer(color: Colors.red, text: 'Leave Request'),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 55)),
                  child: Text(
                    'Student',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color(0xff555555),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 55)),
                  child: Text(
                    'Teacher',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color(0xff555555),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customContainer(
      {required Color color,
      required String text,
      IconData icon = Icons.dashboard_customize_outlined}) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
