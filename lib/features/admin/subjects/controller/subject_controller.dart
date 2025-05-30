import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/admin/subjects/model/subject_model.dart';
import 'package:school_app/features/admin/subjects/services/subject_services.dart';

class SubjectController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  Subject subject = Subject();

// **********Get all teachers*****************
  Future<void> getSubjects() async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await SubjectServices().getsubject();
      print("***********${response.statusCode}");
      log(response.toString());
      if (response.statusCode == 200) {
        final _data = response.data;
        subject = Subject.fromJson(_data);
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  //Clear subjects
  void clearSubjects() {
    // _subjects = [];
    notifyListeners();
  }

  // Add a new subject
  Future<void> addNewSubjects(
    BuildContext context, {
    required String subject,
    required String description,
  }) async {
    _isloadingTwo = true;
    notifyListeners();

    try {
      final response = await SubjectServices().addNewSubject(
        subject: subject,
        description: description,
      );

      if (response.statusCode == 201) {
        log('Subject added successfully.');

        // Show success message
        CustomSnackbar.show(context,
            message: 'Subject added successfully!', type: SnackbarType.success);

        // Navigate to the subjects page
        context.pushNamed(AppRouteConst.SubjectsPageRouteName);
      } else if (response.statusCode == 409) {
        // Handle failure response
        CustomSnackbar.show(context,
            message: response.data['message']['subject'][0],
            type: SnackbarType.info);
      }
    } catch (e) {
      log('Error adding subject: $e');

      CustomSnackbar.show(context,
          message: e.toString(), type: SnackbarType.failure);
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  Future<void> editSubjects(
    BuildContext context, {
    required int subjectid,
    required String subject,
    required String description,
  }) async {
    // final loadingProvider =
    //     Provider.of<LoadingProvider>(context, listen: false); //loading provider
    // loadingProvider.setLoading(true); //start loader
    _isloading = true;
    try {
      final response = await SubjectServices().editSubject(
        subjectid: subjectid,
        subject: subject,
        description: description,
      );
      if (response.statusCode == 200) {
        log(">>>>>>>>>>>>>Subject Edited}");
        // Show success message using Snackbar
        CustomSnackbar.show(context,
            message: 'Subject edited successfully!', type: SnackbarType.info);
        // Navigate to the desired route
        context.pushNamed(
          AppRouteConst.SubjectsPageRouteName,
        );
      } else {
        // Handle failure case here if needed
        CustomSnackbar.show(context,
            message: 'Failed to add subject. Please try again.',
            type: SnackbarType.info);
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(context,
          message: e.toString(), type: SnackbarType.failure);
    } finally {
      // loadingProvider.setLoading(false); // End loader
      _isloading = false;
      notifyListeners();
    }
  }

  //delete subjects
  Future<void> deleteSubjects(BuildContext context,
      {required subjectid}) async {
    _isloading = true;
    notifyListeners();
    try {
      final response =
          await SubjectServices().deleteSubjects(subjectid: subjectid);
      print("***********${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("subject deleted successfully.");
        // Navigator.pop(context);
        await getSubjects();
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
      }
    } catch (e) {
      CustomSnackbar.show(context,
          message: e.toString(), type: SnackbarType.failure);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // **********subject selection************
  int? _selectedSubjectId;
  int? get selectedSubjectId => _selectedSubjectId;
  void selectSubject(int subjectId) {
    _selectedSubjectId = subjectId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedSubjectId = null;
    notifyListeners();
  }
}
