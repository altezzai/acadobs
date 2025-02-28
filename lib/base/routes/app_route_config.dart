import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/authentication/screens/login.dart';
import 'package:school_app/core/authentication/screens/logout.dart';
import 'package:school_app/core/authentication/screens/splashscreen.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
import 'package:school_app/features/admin/duties/screens/addDutyPage.dart';
import 'package:school_app/features/admin/duties/screens/edit_duty_screen.dart';
import 'package:school_app/features/admin/duties/screens/teacher_selection_screen.dart';
import 'package:school_app/features/admin/duties/screens/view_duty.dart';
import 'package:school_app/features/admin/leave_request/screens/leaveRequest_page.dart';
import 'package:school_app/features/admin/leave_request/screens/student_leaveRequest_details.dart';
import 'package:school_app/features/admin/leave_request/screens/teacher_leaveRequest_details.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';
import 'package:school_app/features/admin/notices/screens/add_event.dart';
import 'package:school_app/features/admin/notices/screens/add_notice.dart';
import 'package:school_app/features/admin/notices/screens/edit_event_screen.dart';
import 'package:school_app/features/admin/notices/screens/edit_notice_screen.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';
import 'package:school_app/features/admin/payments/screens/add_donation.dart';
import 'package:school_app/features/admin/payments/screens/add_payment.dart';
import 'package:school_app/features/admin/payments/screens/donation_view.dart';
import 'package:school_app/features/admin/payments/screens/edit_donation_screen.dart';
import 'package:school_app/features/admin/payments/screens/edit_payment_screen.dart';
import 'package:school_app/features/admin/payments/screens/payment_view.dart';
import 'package:school_app/features/admin/payments/screens/single_student_selection_page.dart';
import 'package:school_app/features/admin/reports/screens/donation_report.dart';
import 'package:school_app/features/admin/reports/screens/payment.dart';
import 'package:school_app/features/admin/reports/screens/student_report.dart';
import 'package:school_app/features/admin/reports/screens/teacher_report.dart';
import 'package:school_app/features/admin/student/model/achievement_model.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/model/student_homework.dart';
import 'package:school_app/features/admin/student/screens/achievement_detail.dart';
import 'package:school_app/features/admin/student/screens/addAchivement.dart';
import 'package:school_app/features/admin/student/screens/addhomwork.dart';
import 'package:school_app/features/admin/student/screens/adminhomework_detail.dart';
import 'package:school_app/features/admin/student/screens/newstudent.dart';
import 'package:school_app/features/admin/student/screens/studentdetails.dart';
import 'package:school_app/features/admin/student/screens/studentpage.dart';
import 'package:school_app/features/admin/subjects/model/subject_model.dart';
import 'package:school_app/features/admin/subjects/screens/Add_subject.dart';
import 'package:school_app/features/admin/subjects/screens/edit_subject.dart';
import 'package:school_app/features/admin/subjects/screens/subjects.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/screens/add_teacher.dart';
import 'package:school_app/features/admin/teacher_section/screens/edit_teacher_screen.dart';
import 'package:school_app/features/admin/teacher_section/screens/teacherdetails.dart';
import 'package:school_app/features/admin/teacher_section/screens/teachers_page.dart';
import 'package:school_app/features/parent/chat/screen/parentchatdetailedscreen.dart';
import 'package:school_app/features/parent/chat/screen/parentchatscreen.dart';
import 'package:school_app/features/parent/events/screen/eventdetailedscreen.dart';
import 'package:school_app/features/parent/events/screen/eventscreen.dart';
import 'package:school_app/features/parent/leave_request/model/studentLeaveReq_model.dart';
import 'package:school_app/features/parent/leave_request/screens/add_student_leaveReq.dart';
// import 'package:school_app/features/parent/leave_request/screens/student_leaveRequest.dart';
import 'package:school_app/features/parent/notices/screen/noticedetailedscreen.dart';
import 'package:school_app/features/parent/notices/screen/noticescreen.dart';
import 'package:school_app/features/parent/payment/screen/PaymentScreen.dart';
import 'package:school_app/features/parent/payment/screen/paymentdetailedscreen.dart';
import 'package:school_app/features/parent/payment/screen/student_payment_screen.dart';
import 'package:school_app/features/parent/students/screen/studentdetails.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_record_model.dart';
import 'package:school_app/features/teacher/attendance/screens/attendance_record_screen.dart';
import 'package:school_app/features/teacher/attendance/screens/take_attendance.dart';
import 'package:school_app/features/teacher/duties/duty_detail.dart';
import 'package:school_app/features/teacher/homework/model/homework_model.dart';
import 'package:school_app/features/teacher/homework/screens/student_selection_screen.dart';
import 'package:school_app/features/teacher/homework/screens/subject_selection.dart';
import 'package:school_app/features/teacher/homework/screens/work.dart';
import 'package:school_app/features/teacher/homework/screens/work_screen.dart';
import 'package:school_app/features/teacher/homework/screens/work_view.dart';
import 'package:school_app/features/teacher/leave_request/model/teacherLeaveReq_model.dart';
import 'package:school_app/features/teacher/leave_request/screens/add_teacher_leaverequest.dart';
import 'package:school_app/features/teacher/leave_request/screens/teacher_leaverequestpage.dart';
import 'package:school_app/features/teacher/mark_work/screens/mark_star.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';
import 'package:school_app/features/teacher/marks/screens/marks.dart';
import 'package:school_app/features/teacher/marks/screens/student_marklist.dart';
import 'package:school_app/features/teacher/parent/model/latest_chat_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_student_model.dart';
import 'package:school_app/features/teacher/parent/notes/screens/add_note.dart';
import 'package:school_app/features/teacher/parent/notes/screens/edit_note.dart';
import 'package:school_app/features/teacher/parent/notes/screens/note_details.dart';
import 'package:school_app/features/teacher/parent/notes/screens/notes.dart';
import 'package:school_app/features/teacher/parent/notes/screens/student_note_selection.dart';
import 'package:school_app/features/teacher/parent/notes/screens/teacher_chat_screen.dart';
import 'package:school_app/features/teacher/parent/screens/parents.dart';

import '../../features/admin/student/screens/update_student.dart';

class Approuter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConst.splashRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.loginRouteName,
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.logoutRouteName,
        path: '/logout',
        builder: (context, state) {
          final userType = state.extra
              as UserType; // Extract the userType passed via 'extra'
          return LogoutScreen(
              userType:
                  userType); // Pass the extracted userType to the LogoutScreen
        },
      ),

      GoRoute(
        name: AppRouteConst.bottomNavRouteName,
        path: '/bottomNav',
        pageBuilder: (context, state) {
          final userType = state.extra as UserType;
          return MaterialPage(
              child: BottomNavScreen(
            userType: userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.attendanceRouteName,
        path: '/attendance',
        pageBuilder: (context, state) {
          final attendanceData = state.extra as AttendanceData;
          return MaterialPage(
              child: TakeAttendance(
            attendanceData: attendanceData,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.marksRouteName,
        path: '/marks',
        pageBuilder: (context, state) {
          final MarksUploadModel marksModel = state.extra as MarksUploadModel;
          return MaterialPage(
              child: StudentMarklist(
            marksUploadModel: marksModel,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.dutiesRouteName,
        path: '/duties',
        pageBuilder: (context, state) {
          final DutyDetailArguments args = state.extra as DutyDetailArguments;
          return MaterialPage(
              child: DutyDetailScreen(
            teacherDuty: args.dutyItem,
            index: args.index,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.homeworkRouteName,
        path: '/homework',
        pageBuilder: (context, state) {
          return MaterialPage(child: WorkScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.workviewRouteName,
        path: '/workview',
        pageBuilder: (context, state) {
          final work = state.extra as Homework;
          return MaterialPage(
              child: WorkView(
            work: work,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.addworkRouteName,
        path: '/addwork',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeWork());
        },
      ),
      GoRoute(
        name: AppRouteConst.markstarRouteName,
        path: '/markstar',
        pageBuilder: (context, state) {
          return MaterialPage(child: MarkStar());
        },
      ),
      // GoRoute(
      //   name: AppRouteConst.leaveRouteName,
      //   path: '/leave',
      //   pageBuilder: (context, state) {
      //     return MaterialPage(child: LeaveRequest());
      //   },
      // ),
      GoRoute(
        name: AppRouteConst.studentRouteName,
        path: '/student',
        pageBuilder: (context, state) {
          final UserType userType = state.extra as UserType;
          return MaterialPage(
              child: StudentsPage(
            userType: userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.parentRouteName,
        path: '/parent',
        pageBuilder: (context, state) {
          return MaterialPage(child: ParentsScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.NotesRouteName,
        path: '/notes',
        pageBuilder: (context, state) {
          return MaterialPage(child: NotesScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddNoteRouteName,
        path: '/addnotes',
        pageBuilder: (context, state) {
          // final student = state.extra as Student;
          return MaterialPage(
              child: AddNote(
                  // student:student
                  ));
        },
      ),
      GoRoute(
        name: AppRouteConst.NoteDetailsRouteName,
        path: '/notedetails',
        pageBuilder: (context, state) {
          final int noteId = state.extra as int;

          return MaterialPage(
              child: NoteChatDetailPage(
            noteId: noteId,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.StudentNoteSelectionRouteName,
        path: '/studentnoteselection',
        pageBuilder: (context, state) {
          return MaterialPage(child: StudentNoteSelectionPage());
        },
      ),

      // GoRoute(
      //   name: AppRouteConst.AdminstudentRouteName,
      //   path: '/adminstudent',
      //   pageBuilder: (context, state) {
      //     return MaterialPage(child: StudentsPage());
      //   },
      // ),
      GoRoute(
        name: AppRouteConst.AdminteacherRouteName,
        path: '/adminteacher',
        pageBuilder: (context, state) {
          return MaterialPage(child: TeachersPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminstudentdetailsRouteName,
        path: '/adminstudentdetails',
        pageBuilder: (context, state) {
          final studentArgs = state.extra as StudentDetailArguments;
          // final studentData = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: StudentDetailPage(
              student: studentArgs.student,
              userType: studentArgs.userType,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRouteConst.AddAchivementsRouteName,
        path: '/addachivement',
        pageBuilder: (context, state) {
          final studentId = state.extra as int;
          return MaterialPage(
              child: AddAchievementPage(
            studentId: studentId,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.AchivementDetailRouteName,
        path: '/achivementdetail',
        pageBuilder: (context, state) {
          final Achievement achievement = state.extra as Achievement;
          return MaterialPage(
              child: AchievementDetail(
            achievement: achievement,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminhomeworkDetailRouteName,
        path: '/adminhomeworkdetail',
        pageBuilder: (context, state) {
          final HomeworkDetail homework = state.extra as HomeworkDetail;
          return MaterialPage(
              child: AdminhomeworkDetail(
            homework: homework,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.AddStudentRouteName,
        path: '/addstudent',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddStudentPage());
        },
      ),

      GoRoute(
        name: AppRouteConst.UpdateStudentRountName,
        path: '/updatestudent',
        pageBuilder: (context, state) {
          final student = state.extra as Student;
          return MaterialPage(
              child: EditStudentScreen(
            student: student,
          ));
        },
      ),

      GoRoute(
        name: AppRouteConst.AdminteacherdetailsRouteName,
        path: '/adminteacherdetails',
        pageBuilder: (context, state) {
          // final teacher = state.extra as Map<String, dynamic>;
          final teacher = state.extra as Teacher;
          return MaterialPage(
            child: TeacherDetailsPage(
              teacher: teacher,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminAddDutyRouteName,
        path: '/adminaddduty',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddDutyPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminViewDutyRouteName,
        path: '/adminviewduty',
        pageBuilder: (context, state) {
          final args = state.extra as AdminDutyDetailArguments;
          return MaterialPage(
              child: DutyView(
            dutyId: args.dutyId,
            userType: args.userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.AddNoticeRouteName,
        path: '/addnotice',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddNoticePage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddEventRouteName,
        path: '/addevent',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddEventPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddPaymentRouteName,
        path: '/addpayment',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddPaymentPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddDonationRouteName,
        path: '/addDonation',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddDonationPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddHomeworkRouteName,
        path: '/addhomework',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddHomeworkPage());
        },
      ),
      // GoRoute(
      //   name: AppRouteConst.ParentHomeRouteName,
      //   path: '/parenthome',
      //   pageBuilder: (context, state) {
      //     return MaterialPage(child: ParentHomeScreen());
      //   },
      // ),
      // GoRoute(
      //   name: AppRouteConst.StudentLeaveRequestViewRouteName,
      //   path: '/studentleaverequestview',
      //   pageBuilder: (context, state) {
      //     final LeaveRequestArgs = state.extra as StudentLeaverequestArguments;
      //     return MaterialPage(
      //         child: StudentLeaveRequestScreen(
      //       studentId: LeaveRequestArgs.student.id ?? 0,
      //       userType: LeaveRequestArgs.userType,

      //     ));
      //   },
      // ),
      GoRoute(
        name: AppRouteConst.AddStudentLeaveRequestRouteName,
        path: '/addstudentleaverequest',
        pageBuilder: (context, state) {
          final int studentId = state.extra as int;
          return MaterialPage(
              child: AddStudentLeaveRequest(
            studentId: studentId,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.AddTeacherLeaveRequestRouteName,
        path: '/addteacherleaverequest',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddTeacherLeaveRequest());
        },
      ),
      GoRoute(
        name: AppRouteConst.LeaveRequestScreenRouteName,
        path: '/leaverequestscreen',
        pageBuilder: (context, state) {
          final userType = state.extra as UserType;
          return MaterialPage(
              child: LeaverequestScreen(
            userType: userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.studentLeaveRequestDetailsRouteName,
        path: '/studentleaverequestdetails',
        pageBuilder: (context, state) {
          final studentLeaveRequsetArgs =
              state.extra as StudentLeaveRequestDetailArguments;
          return MaterialPage(
              child: StudentLeaveRequestDetailsPage(
            studentleaverequests: studentLeaveRequsetArgs.studentleaverequests,
            userType: studentLeaveRequsetArgs.userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.teacherLeaveRequestDetailsRouteName,
        path: '/teacherleaverequestdetails',
        pageBuilder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final TeacherLeaveRequest teacherleaverequests =
              extra['teacherLeaveRequest'] as TeacherLeaveRequest;
          final String userType = extra['userType'] as String;

          return MaterialPage(
            child: TeacherLeaveRequestDetailsPage(
              teacherleaverequests: teacherleaverequests,
              userType: userType,
            ),
          );
        },
      ),

      GoRoute(
        name: AppRouteConst.TeacherLeaveRequestScreenRouteName,
        path: '/teacherleaverequestscreen',
        pageBuilder: (context, state) {
          return MaterialPage(child: TeacherLeaverequestScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.ParentStudentDetailRouteName,
        path: '/parentstudentdetail',
        pageBuilder: (context, state) {
          final studentData = state.extra as Map<String, dynamic>;
          return MaterialPage(
              child: ParentStudentDetailPage(
            name: studentData['name'],
            studentClass: studentData['studentClass'],
            image: studentData['image'],
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.EventsPageRouteName,
        path: '/eventspage',
        pageBuilder: (context, state) {
          final bool forNavbar = state.extra as bool;
          return MaterialPage(
              child: EventsPage(
            forNavbar: forNavbar,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.ParentNoticePageRouteName,
        path: '/parentnoticepage',
        pageBuilder: (context, state) {
          final bool forNavbar = state.extra as bool;
          return MaterialPage(
              child: NoticePage(
            forNavbar: forNavbar,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.EventDetailedPageRouteName,
        path: '/eventdetailedpage',
        pageBuilder: (context, state) {
          final args = state.extra as EventDetailArguments;
          return MaterialPage(
              child: EventDetailPage(
            event: args.event,
            userType: args.userType,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.NoticeDetailedPageRouteName,
        path: '/noticedetailedpage',
        pageBuilder: (context, state) {
          final args = state.extra as NoticeDetailArguments;
          return MaterialPage(
            child: NoticeDetailPage(
              notice: args.notice,
              userType: args.userType,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRouteConst.ParentPaymentDetailedPageRouteName,
        path: '/parentpaymentdetailedpage',
        pageBuilder: (context, state) {
          final paymentData = state.extra as Map<String, dynamic>;
          return MaterialPage(
              child: PaymentDetailPage(
            amount: paymentData['amount'],
            description: paymentData['description'],
            file: paymentData['file'],
            transactionId: paymentData['transactionId'],
          ));
        },
      ),
      GoRoute(
          name: AppRouteConst.ParentPaymentPageRouteName,
          path: '/parentpaymentpage',
          pageBuilder: (context, state) {
            return MaterialPage(child: PaymentPage());
          }),

      GoRoute(
        name: AppRouteConst.ParentPaymentScreenRouteName,
        path: '/parentpaymentscreen',
        pageBuilder: (context, state) {
          final int studentId = state.extra as int;
          return MaterialPage(
            child: StudentPaymentScreen(
              studentId: studentId,
            ),
          );
        },
      ),

      GoRoute(
        name: AppRouteConst.AddTeacherRouteName,
        path: '/addteacher',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddTeacher());
        },
      ),
      // Edit teacher
      GoRoute(
        name: AppRouteConst.editTeacherRouteName,
        path: '/editTeacher',
        pageBuilder: (context, state) {
          final teacher = state.extra as Teacher;
          return MaterialPage(
              child: EditTeacherScreen(
            teacher: teacher,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.PaymentReportRouteName,
        path: '/paymentreport',
        pageBuilder: (context, state) {
          return MaterialPage(child: PaymentReport());
        },
      ),
      GoRoute(
        name: AppRouteConst.StudentReportRouteName,
        path: '/studentreport',
        pageBuilder: (context, state) {
          return MaterialPage(child: StudentReport());
        },
      ),
      GoRoute(
        name: AppRouteConst.TeacherReportRouteName,
        path: '/teacherreport',
        pageBuilder: (context, state) {
          return MaterialPage(child: TeacherReport());
        },
      ),
      GoRoute(
        name: AppRouteConst.DonationReportRouteName,
        path: '/donationreport',
        pageBuilder: (context, state) {
          return MaterialPage(child: DonationReport());
        },
      ),

      GoRoute(
        name: AppRouteConst.teacherSelectionRouteName,
        path: '/teacherSelection',
        pageBuilder: (context, state) {
          return MaterialPage(child: TeacherSelectionScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.studentSelectionRouteName,
        path: '/studentSelection',
        pageBuilder: (context, state) {
          final ClassAndDivision classAndDivision =
              state.extra as ClassAndDivision;
          return MaterialPage(
              child: StudentSelectionScreen(
            classAndDivision: classAndDivision,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.singlestudentselectionRouteName,
        path: '/singlestudentSelection',
        pageBuilder: (context, state) {
          final ClassAndDivision classAndDivision =
              state.extra as ClassAndDivision;
          return MaterialPage(
              child: SingleStudentSelectionScreen(
            classAndDivision: classAndDivision,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.PaymentViewRouteName,
        path: '/paymentview',
        pageBuilder: (context, state) {
          final payment = state.extra as Payment;
          return MaterialPage(
              child: PaymentView(
            payment: payment,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.DonationViewRouteName,
        path: '/donationview',
        pageBuilder: (context, state) {
          final donation = state.extra as Donation;
          return MaterialPage(
              child: DonationView(
            donation: donation,
          ));
        },
      ),

      GoRoute(
        name: AppRouteConst.SubjectsPageRouteName,
        path: '/subjectspage',
        pageBuilder: (context, state) {
          return MaterialPage(child: SubjectsScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddSubjectPageRouteName,
        path: '/addsubjectpage',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddSubject());
        },
      ),
      GoRoute(
          name: AppRouteConst.EditSubjectPageRouteName,
          path: '/editsubjectpage',
          pageBuilder: (context, state) {
            final Subject subjects = state.extra as Subject;

            return MaterialPage(child: EditSubjectPage(subjects: subjects));
          }),
      GoRoute(
        name: AppRouteConst.subjectSelectionRouteName,
        path: '/subjectSelection',
        pageBuilder: (context, state) {
          final subjectController = state.extra as TextEditingController;
          return MaterialPage(
              child: SubjectSelectionPage(
            subjectTextEditingController: subjectController,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.parentNoteRouteName,
        path: '/parentNoteScreen',
        pageBuilder: (context, state) {
          final studentId = state.extra as int;
          return MaterialPage(child: ParentNoteScreen(studentId: studentId));
        },
      ),
      GoRoute(
        name: AppRouteConst.parentNoteDetailRouteName,
        path: '/parentNoteDetailScreen',
        pageBuilder: (context, state) {
          final args = state.extra as ParentChatDetailArguments;
          return MaterialPage(
              child: ChatDetailPage(
            studentNote: args.studentNote,
            studentId: args.studentId,
            // teacherId: args.teacherChatId,
          ));
        },
      ),
      GoRoute(
        name: AppRouteConst.teacherChatRouteName,
        path: '/teacherChatScreen',
        pageBuilder: (context, state) {
          final latestChat = state.extra as LatestChat;
          return MaterialPage(child: TeacherChatScreen(latestChat: latestChat));
        },
      ),
      GoRoute(
        name: AppRouteConst.progressreportRouteName,
        path: '/progressReport',
        pageBuilder: (context, state) {
          return MaterialPage(child: ProgressReport());
        },
      ),
      // Edit notice screen
      GoRoute(
        name: AppRouteConst.editNoticeRouteName,
        path: '/editNotice',
        pageBuilder: (context, state) {
          final notice = state.extra as Notice;
          return MaterialPage(
              child: EditNoticeScreen(
            notice: notice,
          ));
        },
      ),
      //  Edit event
      GoRoute(
        name: AppRouteConst.editEventRouteName,
        path: '/editEvent',
        pageBuilder: (context, state) {
          final event = state.extra as Event;
          return MaterialPage(
              child: EditEventScreen(
            event: event,
          ));
        },
      ),
      //  Edit event
      GoRoute(
        name: AppRouteConst.editPaymentRouteName,
        path: '/editPayment',
        pageBuilder: (context, state) {
          final payment = state.extra as Payment;
          return MaterialPage(
              child: EditPaymentScreen(
            payment: payment,
          ));
        },
      ),
      //  Edit event
      GoRoute(
        name: AppRouteConst.editDonationRouteName,
        path: '/editDonation',
        pageBuilder: (context, state) {
          final donation = state.extra as Donation;
          return MaterialPage(
              child: EditDonationScreen(
            donation: donation,
          ));
        },
      ),
      //  Edit duty
      GoRoute(
        name: AppRouteConst.editDutyRouteName,
        path: '/editDuty',
        pageBuilder: (context, state) {
          final duty = state.extra as Duty;
          return MaterialPage(
              child: EditDutyScreen(
            duty: duty,
          ));
        },
      ),
      // Edit note
      GoRoute(
        name: AppRouteConst.editNoteRouteName,
        path: '/editNote',
        pageBuilder: (context, state) {
          final note = state.extra as ParentNote;
          return MaterialPage(
              child: EditNote(
            note: note,
          ));
        },
      ),
      //Attendance record
      GoRoute(
        name: AppRouteConst.attendanceRecordRouteName,
        path: '/attendanceRecord',
        pageBuilder: (context, state) {
          final AttendanceRecordArguments args = state.extra as AttendanceRecordArguments;
          return MaterialPage(
              child: AttendanceRecordScreen(
                forEditScreen: args.forEditScreen,
            attendanceRecord: args.attendanceRecord,
          ));
        },
      ),
    ],
  );

  
}

class AttendanceRecordArguments {
  bool forEditScreen;
  AttendanceRecord attendanceRecord;
  AttendanceRecordArguments({required this.forEditScreen, required this.attendanceRecord});
}

class ClassAndDivision {
  String className;
  String section;
  ClassAndDivision({required this.className, required this.section});
}

class DutyDetailArguments {
  DutyItem dutyItem;
  int index;
  DutyDetailArguments({required this.dutyItem, required this.index});
}

class AdminDutyDetailArguments {
  int dutyId;
  UserType userType;
  AdminDutyDetailArguments({required this.dutyId, required this.userType});
}

class StudentDetailArguments {
  Student student;
  UserType userType;
  StudentDetailArguments({required this.student, required this.userType});
}

class StudentLeaveRequestDetailArguments {
  StudentLeaveRequest studentleaverequests;
  UserType userType;
  StudentLeaveRequestDetailArguments({
    required this.studentleaverequests,
    required this.userType,
  });
}

class NoticeDetailArguments {
  Notice notice;
  UserType userType;
  NoticeDetailArguments({required this.notice, required this.userType});
}

class EventDetailArguments {
  Event event;
  UserType userType;
  EventDetailArguments({required this.event, required this.userType});
}

class StudentLeaverequestArguments {
  Student student;
  UserType userType;
  StudentLeaverequestArguments({required this.student, required this.userType});
}

class ChatDetailArguments {
  NoteData studentNote;
  int teacherChatId;
  ChatDetailArguments({required this.studentNote, required this.teacherChatId});
}

class ParentChatDetailArguments {
  NoteData studentNote;
  int studentId;
  ParentChatDetailArguments(
      {required this.studentNote, required this.studentId});
}
