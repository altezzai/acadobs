import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/student_id_services.dart';

class StudentIdController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> get students => List.unmodifiable(_students);

  // List to store selected student IDs
  final List<int> _selectedStudentIds = [];
  List<int> get selectedStudentIds => List.unmodifiable(_selectedStudentIds);

  String? selectedStudentId;

  Future<void> getStudentsFromClassAndDivision({
    required String className,
    required String section,
  }) async {
    _isloading = true;
    notifyListeners(); // Ensure UI updates immediately

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
      }
    } catch (e) {
      print(e.toString());
    }

    _isloading = false;
    notifyListeners();
  }

  void setSelectedStudentId(String? studentId) {
    selectedStudentId = studentId;
    notifyListeners();
  }

  // Single student selection logic
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
    _selectedStudentIds.clear();
    notifyListeners();
  }

  // **Fixed selectAllStudents()**
  void selectAllStudents() {
    _selectedStudentIds.clear(); // Clear previous selections
    _selectedStudentIds
        .addAll(_students.map((student) => student['id'] as int));
    notifyListeners();
  }

  // Multiple student selection for homework assigning
  void toggleStudentSelection(int studentId) {
    if (_selectedStudentIds.contains(studentId)) {
      _selectedStudentIds.remove(studentId);
    } else {
      _selectedStudentIds.add(studentId);
    }
    notifyListeners();
  }

  // Check if a student is selected
  bool isStudentSelected(int studentId) {
    return _selectedStudentIds.contains(studentId);
  }

  // Clear selected student IDs
  void clearStudentIdsSelection() {
    _selectedStudentIds.clear();
    notifyListeners();
  }
}
