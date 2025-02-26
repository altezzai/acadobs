import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/loading_dialog.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
// import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
import 'package:school_app/features/admin/duties/services/duty_services.dart';

class DutyController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
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
  Future<void> addDuty(BuildContext context,
      {required String duty_title,
      required String description,
      required String status,
      required String remark,
      required List<int> teachers,
      String? fileattachment}) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await DutyServices().addDuty(
          duty_title: duty_title,
          description: description,
          status: status,
          remark: remark,
          teachers: teachers,
          fileAttachment: fileattachment);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Duty added successfully!", type: SnackbarType.success);

        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false; // End loader
      notifyListeners();
    }
  }

  // ******** Edit Duty *******
  Future<void> editDuty(BuildContext context,
      {required int dutyId,
      required String duty_title,
      required String description,
      required String status,
      required String remark,
      required List<int> teachers,
      String? fileattachment}) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await DutyServices().editDuty(
          dutyId: dutyId,
          duty_title: duty_title,
          description: description,
          status: status,
          remark: remark,
          teachers: teachers,
          fileAttachment: fileattachment);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        await getDuties();
        CustomSnackbar.show(context,
            message: "Duty Edited successfully!", type: SnackbarType.success);

        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false; // End loader
      notifyListeners();
    }
  }

  Future<void> progressDuty(BuildContext context,
      {required int duty_id}) async {
    try {
      final response = await DutyServices().progressDuty(duty_id: duty_id);
      if (response.statusCode == 201 || response.statusCode == 200) {
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
      if (response.statusCode == 201 || response.statusCode == 200) {
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

  // delete
  Future<void> deleteDuties(BuildContext context, {required int dutyId}) async {
    _isloading = true;
    LoadingDialog.show(context, message: "Deleting duty...");
    try {
      final response = await DutyServices().deleteDuties(dutyId: dutyId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("duty deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
        await getDuties();
      }
    } catch (e) {
      // print(e);
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }

  Duty dutyFullDetail = Duty();
  DutyClass singleDuty = DutyClass();

  Future<void> getSingleDuty({required int dutyId}) async {
    _isloading = true;
    try {
      final response = await DutyServices().getSingleDuty(dutyId: dutyId);
      log("Single Duty response :${response.data.toString()}");
      if (response.statusCode == 200) {
        final temp1 = Duty.fromJson(response.data);
        dutyFullDetail = temp1;
        final temp2 = DutyClass.fromJson(response.data["duty"]);
        singleDuty = temp2;
        log("Single Duty: ${singleDuty.toString()}");
        notifyListeners(); // Ensure UI updates
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
