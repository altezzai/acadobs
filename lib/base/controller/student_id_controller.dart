import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/student_id_services.dart';

class StudentIdController extends ChangeNotifier {
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> get students => _students;

  String? selectedStudentId;

  Future<void> getStudentsFromClassAndDivision({
    required String className,
    required String section,
  }) async {
    try {
      final response = await StudentIdServices()
          .getStudentsFromClassAndDivision(
              className: className, section: section);
      if (response.statusCode == 200) {
        _students = (response.data as List<dynamic>).map((student) {
          return {
            'full_name': student['full_name'],
            'id': student['id'],
          };
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void setSelectedStudentId(String? studentId) {
    selectedStudentId = studentId;
    notifyListeners();
  }
}
