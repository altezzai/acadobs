import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:school_app/features/admin/reports/model/teacher_report_model.dart';
import 'package:school_app/features/admin/reports/services/teacher_report_services.dart';

class TeacherReportController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isFiltered = false; // New flag to track filtering
  bool get isFiltered =>
      _isFiltered; // Public getter to access the filter state

  List<TeacherReport> _teacherreports = [];
  List<TeacherReport> get teacherreports => _teacherreports;

  List<TeacherReport> _filteredteacherreports = [];
  List<TeacherReport> get filteredteacherreports => _filteredteacherreports;

  /// Fetch all teacher reports
  Future<void> getTeacherReports() async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await TeacherReportServices().getTeacherReport();
      log("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        _teacherreports = (response.data as List<dynamic>)
            .map((result) => TeacherReport.fromJson(result))
            .toList();
      } else {
        log("Failed to fetch reports: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching reports: $e");
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  /// Fetch reports by teacher name and date range
  Future<void> getTeacherReportsByNameAndDate({
    // required String teacherName,
    required String startDate,
    required String endDate,
  }) async {
    _isloading = true;
    _isFiltered = false;
    notifyListeners();
    try {
      final response =
          await TeacherReportServices().getTeacherReportByNameAndDate(
        // teacherName: teacherName,
        startDate: startDate,
        endDate: endDate,
      );
      log("Filter response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        _filteredteacherreports = (response.data as List<dynamic>)
            .map((result) => TeacherReport.fromJson(result))
            .toList();
      } else {
        log("No reports found for filters: ${response.statusCode}");
      }
    } catch (e) {
      log("Error filtering reports: $e");
    } finally {
      _isloading = false;
      _isFiltered = true;
      notifyListeners();
    }
  }

  /// Clear filtered reports list
  void clearTeacherReportList() {
    _filteredteacherreports.clear();
    notifyListeners();
  }

  void resetFilter() {
    _isFiltered = false;
    _filteredteacherreports = []; // Clear the list of filtered payments
    notifyListeners(); // Notify listeners to update the UI
  }
}
