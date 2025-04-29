import 'package:flutter/widgets.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/superadmin/models/classes_model.dart';
import 'package:school_app/features/superadmin/services/super_admin_services.dart';

class SchoolClassController extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;

  bool _isLoadingTwo = false;
  bool get isLoadingTwo => _isLoadingTwo;

  List<SchoolClass> schoolClasses = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;

  // Get all Classes - Pagination
  Future<void> getAllSchoolClasses({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= lastPage || isLoadingMore) return;
      isLoadingMore = true;
      currentPage += 1; // ✅ move increment here
      notifyListeners();
    } else {
      _isloading = true;
      currentPage = 1;
      schoolClasses.clear();
      notifyListeners();
    }

    try {
      final response =
          await SuperAdminServices().getAllClasses(pageNo: currentPage);
      final data = response.data;

      final List<dynamic> schoolClassesList = data['classes'];
      final List<SchoolClass> fetchedSchoolClasses =
          schoolClassesList.map((json) => SchoolClass.fromJson(json)).toList();

      schoolClasses.addAll(fetchedSchoolClasses);

      lastPage = data['totalPages'];
    } catch (e) {
      print('Error fetching Classes: $e');
    } finally {
      _isloading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  //   Add a class
  Future<void> addClass(
    context, {
    required String year,
    required String division,
    required String classname,
  }) async {
    _isLoadingTwo = true;
    notifyListeners();

    try {
      final response = await SuperAdminServices().addClass(
        year: year,
        division: division,
        classname: classname,
      );

      if (response.statusCode == 201) {
        print('Class added successfully.');
        await getAllSchoolClasses();
        CustomSnackbar.show(context,
            message: 'Class added successfully!', type: SnackbarType.success);
        Navigator.pop(context);
      } else {
        print('Failed to add class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding class: $e');
    } finally {
      _isLoadingTwo = false;
      notifyListeners();
    }
  }

  // Edit a class
  Future<void> editClass(
    context, {
    required int classId,
    required String year,
    required String division,
    required String classname,
  }) async {
    _isLoadingTwo = true;
    notifyListeners();

    try {
      final response = await SuperAdminServices().editClass(
          classId: classId,
          year: year,
          division: division,
          classname: classname);

      if (response.statusCode == 200) {
        print('Class edited successfully.');
        await getAllSchoolClasses();
        CustomSnackbar.show(context,
            message: 'Class edited successfully!', type: SnackbarType.success);
        Navigator.pop(context);
      } else {
        print('Failed to edit class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error editing class: $e');
    } finally {
      _isLoadingTwo = false;
      notifyListeners();
    }
  }

  // Delete a class
  Future<void> deleteClass(context, {required int classId}) async {
    try {
      final response = await SuperAdminServices().deleteClass(classId: classId);
      if (response.statusCode == 200) {
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
      } else {
        print('Failed to delete class: ${response.statusCode}');
      }
      schoolClasses.removeWhere((classes) => classes.id == classId);
      notifyListeners();
    } catch (e) {
      print('Error deleting class: $e');
    }
  }
}
