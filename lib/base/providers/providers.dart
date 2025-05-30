import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/core/authentication/controller/auth_controller.dart';
import 'package:school_app/core/controller/date_provider.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/controller/bottom_nav_controller.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/reports/controller/student_report_controller.dart';
import 'package:school_app/features/admin/reports/controller/teacher_report_controller.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/controller/exam_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';
import 'package:school_app/features/superadmin/bottom_nav/bottom_navbar_controller.dart';
import 'package:school_app/features/superadmin/school_classes/controller/school_classes_controller.dart';
import 'package:school_app/features/superadmin/school_subjects/controller/school_subjects_controller.dart';
import 'package:school_app/features/superadmin/schools/controller/school_controller.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/controller/tile_selection.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

getProviders() {
  return [
    //**********SUPER ADMIN************//
    ChangeNotifierProvider(create: (_) => BottomNavbarController()),
    ChangeNotifierProvider(create: (_) => SchoolController()),
    ChangeNotifierProvider(create: (_) => SchoolClassController()),
    ChangeNotifierProvider(create: (_) => SchoolSubjectsController()),

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
    ChangeNotifierProvider(create: (_) => StudentLeaveRequestController()),
    ChangeNotifierProvider(create: (_) => DutyController()),
    ChangeNotifierProvider(create: (_) => FilePickerProvider()),
    ChangeNotifierProvider(create: (_) => AchievementController()),
    ChangeNotifierProvider(create: (_) => AchievementController()),
    ChangeNotifierProvider(create: (_) => DateProvider()),
    ChangeNotifierProvider(create: (_) => HomeworkController()),
    ChangeNotifierProvider(create: (_) => MarksController()),
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => SubjectController()),
    ChangeNotifierProvider(create: (_) => ExamController()),
    ChangeNotifierProvider(create: (_) => StudentReportController()),
    ChangeNotifierProvider(create: (_) => TeacherReportController()),
    ChangeNotifierProvider(create: (_) => NotesController()),
  ];
}
