import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/controller/bottom_nav_controller.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/teacher/attendance/controller/tile_selection.dart';
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';

getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => DropdownProvider()),
    ChangeNotifierProvider(create: (_) => AttendanceController()),
    ChangeNotifierProvider(create: (_) => StudentController()),
    ChangeNotifierProvider(create: (_) => BottomNavController()),
    ChangeNotifierProvider(create: (_) => TeacherController()),
    ChangeNotifierProvider(create: (_) => NoticeController()),
    ChangeNotifierProvider(create: (_) => LoadingProvider()),
    ChangeNotifierProvider(create: (_) => PaymentController()),
    ChangeNotifierProvider(create: (_) => StudentIdController()),
    ChangeNotifierProvider(create: (_) => TileSelectionProvider()),

    ChangeNotifierProvider(create: (_) => TeacherLeaveRequestController()),

    ChangeNotifierProvider(create: (_) => DutyController()),
    ChangeNotifierProvider(create: (_) => AchievementController()),
  ];
}
