import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
// import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
import 'package:school_app/features/admin/duties/services/duty_services.dart';

class DutyController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<DutyClass> _duties = [];
  List<DutyClass> get duties => _duties;
  List<AssignedTeacher> _assignedteachers = [];
  List<AssignedTeacher> get assignedteachers => _assignedteachers;
  List<DutyItem> _teacherduties = [];
  List<DutyItem> get teacherDuties => _teacherduties;

  Future<void> getDuties() async {
    _isloading = true;
    try {
      final response = await DutyServices().getDuties();
      print("***********${response.statusCode}");
      duties.clear();
      // print(response.toString());
      if (response.statusCode == 200) {
        _duties = (response.data as List<dynamic>)
            .map((result) => DutyClass.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // get assigned teachers
  Future<void> getAssignedDuties({required String dutyid}) async {
    _isloading = true;
    try {
      final response = await DutyServices().getAssignedDuties(dutyid: dutyid);
      print("***********${response.statusCode}");
      _assignedteachers.clear();
      // print(response.toString());
      if (response.statusCode == 200) {
        _assignedteachers =
            (response.data['assigned_teachers'] as List<dynamic>)
                .map((result) => AssignedTeacher.fromJson(result))
                .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // *********Get teacher duties
  Future<void> getTeacherDuties() async {
    _isloading = true;
    final teacherId = await SecureStorageService.getUserId();
    log("Userid===== ${teacherId.toString()}");
    try {
      final response = await DutyServices()
          .getTeacherDuties(teacherid: int.parse(teacherId.toString()));
      print("***********${response.statusCode}");
      _teacherduties.clear();
      // print(response.toString());
      if (response.statusCode == 200) {
        _teacherduties = (response.data['duties'] as List<dynamic>)
            .map((result) => DutyItem.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // *******Get teacher single duty
  Map<String, dynamic> _singleTeacherDuty = {};
  Map<String, dynamic> get singleTeacherDuty => _singleTeacherDuty;

  Future<void> getTeacherSingleDuty({required int dutyId}) async {
    _isloading = true;
    notifyListeners(); // Notify listeners before fetching data
    final teacherId = await SecureStorageService.getUserId();
    log("UserID: $teacherId");

    try {
      final response = await DutyServices().getTeacherSingleDuty(
        teacherId: int.parse(teacherId.toString()),
        dutyId: dutyId,
      );
      log("Response Data: ${response.data}");
      if (response.statusCode == 200) {
        final dutiesList = response.data['duties'] as List;
        if (dutiesList.isNotEmpty) {
          _singleTeacherDuty = dutiesList[0]; // Assign the first duty
          log("Single Duty Updated: $_singleTeacherDuty");
        } else {
          log("No duties found for the teacher.");
        }
      }
    } catch (e) {
      log("Error Fetching Duty: $e");
    } finally {
      _isloading = false;
      notifyListeners(); // Ensure UI updates
    }
  }

// ******** Add Duty *******
  Future<void> addDuty(
    BuildContext context, {
    required String duty_title,
    required String description,
    required String status,
    required String remark,
    required List<int> teachers,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await DutyServices().addDuty(
        duty_title: duty_title,
        description: description,
        status: status,
        remark: remark,
        teachers: teachers,
      );
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }

  Future<void> progressDuty(BuildContext context,
      {required int duty_id}) async {
    try {
      final response = await DutyServices().progressDuty(duty_id: duty_id);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Duty In Progress", type: SnackbarType.info);
        Navigator.pop(context);
        // Fetch updated data
        // await getTeacherSingleDuty(dutyId: duty_id);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> completeDuty(BuildContext context,
      {required int duty_id}) async {
    try {
      final response = await DutyServices().completeDuty(duty_id: duty_id);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Duty Completed", type: SnackbarType.success);
        Navigator.pop(context);
        // Fetch updated data
        // await getTeacherSingleDuty(dutyId: duty_id);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
  }

// Get teacher duties in admin
  Future<void> getAdminTeacherDuties({required int teacherId}) async {
    _isloading = true;
    // final teacherId = await SecureStorageService.getUserId();
    log("Userid===== ${teacherId.toString()}");
    try {
      final response = await DutyServices()
          .getTeacherDuties(teacherid: int.parse(teacherId.toString()));
      print("***********${response.statusCode}");
      _teacherduties.clear();
      // print(response.toString());
      if (response.statusCode == 200) {
        _teacherduties = (response.data['duties'] as List<dynamic>)
            .map((result) => DutyItem.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }
}
