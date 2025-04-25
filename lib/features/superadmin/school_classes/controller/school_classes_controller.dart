import 'package:flutter/widgets.dart';
import 'package:school_app/features/superadmin/models/classes_model.dart';
import 'package:school_app/features/superadmin/services/super_admin_services.dart';

class SchoolClassController  extends ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;

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
}