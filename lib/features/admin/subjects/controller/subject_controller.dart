import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/features/admin/subjects/model/subject_model.dart';
import 'package:school_app/features/admin/subjects/services/subject_services.dart';

class SubjectController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

// **********Get all teachers*****************
  Future<void> getSubjects() async {
    _isloading = true;
    try {
      final response = await SubjectServices().getsubject();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _subjects = (response.data as List<dynamic>)
            .map((result) => Subject.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
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

    // Check if the subject already exists
    final subjectExists =
        _subjects.any((s) => s.subject?.toLowerCase() == subject.toLowerCase());

    if (subjectExists) {
      // Show error message for duplicate subject
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subject already exists. Please try a different name.'),
          backgroundColor: Colors.red,
        ),
      );
      _isloadingTwo = false;
      notifyListeners();
      return;
    }

    try {
      final response = await SubjectServices().addNewSubject(
        subject: subject,
        description: description,
      );

      if (response.statusCode == 201) {
        log('Subject added successfully.');

        // Add the new subject to the list and notify listeners
        _subjects.add(Subject(
          id: response.data['id'],
          subject: subject,
          description: description,
          trash: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Subject added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the subjects page
        context.pushNamed(AppRouteConst.SubjectsPageRouteName);
      } else {
        // Handle failure response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add subject. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      log('Error adding subject: $e');
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Subject edited successfully!'),
            backgroundColor: Colors.green, // Set color for success
          ),
        );
        // Navigate to the desired route
        context.pushNamed(
          AppRouteConst.SubjectsPageRouteName,
        );
      } else {
        // Handle failure case here if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add subject. Please try again.'),
            backgroundColor: Colors.red, // Set color for error
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      // loadingProvider.setLoading(false); // End loader
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
}
