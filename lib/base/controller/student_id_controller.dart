import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/student_id_services.dart';

class StudentIdController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> get students => _students;

  String? selectedStudentId;

  Future<void> getStudentsFromClassAndDivision({
    required String className,
    required String section,
  }) async {
    _isloading = true;
    try {
      final response = await StudentIdServices()
          .getStudentsFromClassAndDivision(
              className: className, section: section);
      if (response.statusCode == 200) {
        _students.clear();
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
    _isloading = false;
  }

  void setSelectedStudentId(String? studentId) {
    selectedStudentId = studentId;
    notifyListeners();
  }

  // selection student
  int? _selectedStudentIndex;

  bool isSelected(int index) => _selectedStudentIndex == index;

  void toggleSelection(int index) {
    if (_selectedStudentIndex == index) {
      _selectedStudentIndex = null; // Deselect if already selected
    } else {
      _selectedStudentIndex = index; // Select new student
    }
    notifyListeners();
  }

  int? getSelectedStudentId() {
    if (_selectedStudentIndex != null) {
      return students[_selectedStudentIndex!]['id'];
    }
    return null;
  }

  // Clear all selections
  void clearSelection() {
    _selectedStudentIndex = null;
    _students.clear();
    notifyListeners();
  }
}
