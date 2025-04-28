import 'package:flutter/widgets.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/superadmin/models/school_model.dart';
import 'package:school_app/features/superadmin/services/super_admin_services.dart';

class SchoolController extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;

  bool _isLoadingTwo = false;
  bool get isLoadingTwo => _isLoadingTwo;

  List<School> schools = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;

  // Get all schools - Pagination
  Future<void> getAllSchools({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= lastPage || isLoadingMore) return;
      isLoadingMore = true;
      currentPage += 1; // ✅ move increment here
      notifyListeners();
    } else {
      _isloading = true;
      currentPage = 1;
      schools.clear();
      notifyListeners();
    }

    try {
      final response =
          await SuperAdminServices().getAllSchools(pageNo: currentPage);
      final data = response.data;

      final List<dynamic> schoolList = data['schools'];
      final List<School> fetchedSchools =
          schoolList.map((json) => School.fromJson(json)).toList();

      schools.addAll(fetchedSchools);

      lastPage = data['totalPages'];
    } catch (e) {
      print('Error fetching schools: $e');
    } finally {
      _isloading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

// Add a new school
  Future<void> addSchool(
    context, {
    required String name,
    required String email,
    required String phone,
    required String address,
    required String adminPassword,
  }) async {
    _isLoadingTwo = true;
    notifyListeners();

    try {
      final response = await SuperAdminServices().addSchool(
          name: name,
          email: email,
          phone: phone,
          address: address,
          adminPassword: adminPassword);

      if (response.statusCode == 201) {
        print('School added successfully.');
        await getAllSchools();
        CustomSnackbar.show(context,
            message: 'School added successfully!', type: SnackbarType.success);
        Navigator.pop(context);
      } else {
        print('Failed to add school: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding school: $e');
    } finally {
      _isLoadingTwo = false;
      notifyListeners();
    }
  }

  // Edit a school
  Future<void> editSchool(
    context, {
    required int schoolId,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    _isLoadingTwo = true;
    notifyListeners();

    try {
      final response = await SuperAdminServices().editSchool(context,
          schoolId: schoolId,
          name: name,
          email: email,
          phone: phone,
          address: address);

      if (response.statusCode == 200) {
        print('School edited successfully.');
        await getAllSchools();
        CustomSnackbar.show(context,
            message: 'School edited successfully!', type: SnackbarType.success);
        Navigator.pop(context);
      } else {
        print('Failed to edit school: ${response.statusCode}');
      }
    } catch (e) {
      print('Error editing school: $e');
    } finally {
      _isLoadingTwo = false;
      notifyListeners();
    }
  }

  // Delete a school
  Future<void> deleteSchool(context, {required int schoolId}) async {
    try {
      final response =
          await SuperAdminServices().deleteSchool(schoolId: schoolId);
      if (response.statusCode == 200) {
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
      } else {
        print('Failed to delete school: ${response.statusCode}');
      }
      schools.removeWhere((school) => school.id == schoolId);
      notifyListeners();
    } catch (e) {
      print('Error deleting school: $e');
    }
  }
}
