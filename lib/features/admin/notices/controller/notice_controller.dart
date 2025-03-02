import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/loading_dialog.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';
import 'package:school_app/features/admin/notices/services/notice_services.dart';

class NoticeController extends ChangeNotifier {
  // get notices
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  List<Notice> _notices = [];
  List<Notice> get notices => _notices;

  Future<void> getNotices() async {
    _isloading = true;
    try {
      final response = await NoticeServices().getNotices();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _notices = (response.data as List<dynamic>)
            .map((result) => Notice.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // get events
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> getEvents() async {
    _isloading = true;
    // notifyListeners();
    try {
      final response = await NoticeServices().getEvents();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _events = (response.data as List<dynamic>)
            .map((result) => Event.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  List<Event> _singleevent = [];
  List<Event> get singleevent => _singleevent;
  Future<void> getSingleEvent({required int eventId}) async {
    _isloading = true;
    // notifyListeners();
    try {
      final response = await NoticeServices().getSingleEvent(eventId: eventId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _singleevent = (response.data as List<dynamic>)
            .map((result) => Event.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // add notice
  Future<void> addNotice(
    BuildContext context, {
    required String audience_type,
    required String title,
    required String description,
    required String date,
    String? className,
    String? division,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await NoticeServices().addNotice(context,
          title: title,
          description: description,
          date: date,
          className: className,
          division: division,
          audience_type: audience_type);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");

        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
        CustomSnackbar.show(context,
            message: 'Notice Added successfully', type: SnackbarType.success);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // edit notice
  Future<void> editNotice(
    BuildContext context, {
    required int noticeId,
    required String audience_type,
    required String title,
    required String description,
    required String date,
    String? className,
    String? division,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await NoticeServices().editNotice(context,
          noticeId: noticeId,
          title: title,
          description: description,
          date: date,
          className: className,
          division: division,
          audience_type: audience_type);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");

        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
        CustomSnackbar.show(context,
            message: 'Notice Updated successfully', type: SnackbarType.success);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // add events
  Future<void> addEvent(
    BuildContext context, {
    required String title,
    required String description,
    required String date,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await NoticeServices().addEvent(
          title: title,
          description: description,
          date: date,
          images: _chosenFiles);
      log(response.data.toString());
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        log("Images to upload: ${chosenFiles?.map((e) => e.path).toList()}");
        CustomSnackbar.show(context,
            message: 'Event Edited successfully', type: SnackbarType.success);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

// Edit events
  Future<void> editEvent(
    BuildContext context, {
    required int eventId,
    required String title,
    required String description,
    required String date,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await NoticeServices().editEvent(
          eventId: eventId,
          title: title,
          description: description,
          date: date,
          images: _chosenFiles);
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        log("Images to upload: ${chosenFiles?.map((e) => e.path).toList()}");
        CustomSnackbar.show(context,
            message: 'Event Added successfully', type: SnackbarType.success);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // final ImagePicker _picker = ImagePicker();
  List<XFile> _chosenFiles = []; // List to store selected images

  List<XFile>? get chosenFiles => _chosenFiles;

  Future<void> pickMultipleImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? selectedImages = await picker.pickMultiImage();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        _chosenFiles.addAll(selectedImages); // Append new images
        notifyListeners();
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _chosenFiles.length) {
      print("Before remove: ${_chosenFiles.length} images");
      _chosenFiles.removeAt(index);
      notifyListeners();
      print("After remove: ${_chosenFiles.length} images");
    }
  }

  // void removeChosenImage(int index) {
  //   if (index >= 0 && index < chosenFiles!.length) {
  //     chosenFiles!.removeAt(index);
  //     notifyListeners(); // Ensures UI updates properly
  //   }
  // }

  // Optional: Clear selected images
  void clearSelectedImages() {
    _chosenFiles = [];
    notifyListeners();
  }

// delete notices
  Future<void> deleteNotices(BuildContext context,
      {required int noticeId}) async {
    _isloading = true;
    notifyListeners();
    LoadingDialog.show(context, message: "Deleting notice...");
    try {
      final response = await NoticeServices().deleteNotices(noticeId: noticeId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("notice deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
      }
    } catch (e) {
      // print(e);
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }

// delete events
  Future<void> deleteEvents(BuildContext context,
      {required int eventId}) async {
    _isloading = true;
    notifyListeners();
    LoadingDialog.show(context, message: "Deleting event...");
    try {
      final response = await NoticeServices().deleteEvents(eventId: eventId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("event deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
      }
    } catch (e) {
      // print(e);
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }

  // delete event images
  Future<void> deleteEventImage(BuildContext context,
      {required int imageId, required int eventId}) async {
    _isloading = true;
    notifyListeners();
    // LoadingDialog.show(context, message: "Deleting event image...");
    try {
      final response =
          await NoticeServices().deleteEventImage(imageId: imageId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getSingleEvent(eventId: eventId);
        log("event image deleted successfully.");
      }
    } catch (e) {
      // print(e);
    } finally {
      _isloading = false;
      notifyListeners();
      // LoadingDialog.hide(context);
    }
  }
}
