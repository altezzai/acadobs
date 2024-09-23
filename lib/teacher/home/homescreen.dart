import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/studentpage.dart';
import 'package:school_app/teacher/leave_request/leave_request.dart';
import 'package:school_app/teacher/parent/screens/parents.dart';
import 'package:school_app/utils/responsive.dart';
import 'package:school_app/teacher/homework/screens/work_screen.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Responsive.height * 7,
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
                            .copyWith(color: const Color(0xff555555)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/admin.png'),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 20,
              ),
              _customContainer(
                  color: Colors.green,
                  text: 'Homework',
                  ontap: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WorkScreen()));

                  }),
              const SizedBox(
                height: 10,
              ),
              _customContainer(
                  color: Colors.red,
                  text: 'Leave Request',
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LeaveRequest(), //Navigation to the student page
                      ),
                    );
                  }),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentsPage(), //Navigation to the student page
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: Responsive.height * 3,
                            horizontal: Responsive.width * 12)),
                    child: Text(
                      'Student',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(0xff555555),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  OutlinedButton(
                    onPressed: () {
                       Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ParentsScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.height * 3,
                          horizontal: Responsive.width * 12),
                    ),
                    child: Text(
                      'Teacher',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(0xff555555),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customContainer({
    required Color color,
    required String text,
    IconData icon = Icons.dashboard_customize_outlined,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
