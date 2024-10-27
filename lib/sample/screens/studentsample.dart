// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_app/features/admin/student/controller/student_controller.dart';

// class Studentsample extends StatefulWidget {
//   const Studentsample({super.key});

//   @override
//   State<Studentsample> createState() => _StudentsampleState();
// }

// class _StudentsampleState extends State<Studentsample> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SampleController>().getStudentDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Student Sample',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Consumer<SampleController>(builder: (context, value, child) {
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(value.studentData[index].fullName ?? ""),
//               subtitle: Text(value.studentData[index].fatherFullName ?? ""),
//             );
//           },
//           itemCount: value.studentData.length,
//         );
//       }),
//     );
//   }
// }
