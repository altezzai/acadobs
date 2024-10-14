

import 'package:provider/provider.dart';
import 'package:school_app/core/navbar/controller/bottom_nav_controller.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/controller/dropdown_controller.dart';
import 'package:school_app/sample/controller/student_controller.dart';

getProviders(){
 return [
              ChangeNotifierProvider(create: (_) => DropdownProvider()),
              ChangeNotifierProvider(create: (_) => AttendanceController()),
              ChangeNotifierProvider(create: (_) => SampleController()),
              ChangeNotifierProvider(create: (_) => BottomNavController()),
  ];
}