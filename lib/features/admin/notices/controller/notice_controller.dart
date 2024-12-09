import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';
import 'package:school_app/features/admin/notices/services/notice_services.dart';

class NoticeController extends ChangeNotifier {
  // get notices
  bool _isloading = false;
  bool get isloading => _isloading;
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
    _isloading =true;
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

  // add events
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
    // final loadingProvider =
    //     Provider.of<LoadingProvider>(context, listen: false); //loading provider
    // loadingProvider.setLoading(true); //start loader
    _isloading = true;
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
      }
    } catch (e) {
      log(e.toString());
    } finally {
      // loadingProvider.setLoading(false); // End loader
      _isloading = false;
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
    // final loadingProvider =
    //     Provider.of<LoadingProvider>(context, listen: false); //loading provider
    // loadingProvider.setLoading(true); //start loader
    _isloading = true;
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

        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      // loadingProvider.setLoading(false); // End loader
      _isloading =false;
      notifyListeners();
    }
  }

  // *********** Add cover photo***************
  // XFile? _chosenFile; // Chosen image file
  // final ImagePicker _picker = ImagePicker();

  // XFile? get chosenFile => _chosenFile;

  // // Function to pick an image from the camera or gallery
  // Future<void> pickImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       log('Picked file path: ${pickedFile.path}');
  //       _chosenFile = pickedFile;
  //       notifyListeners(); // Notify listeners to rebuild UI
  //     } else {
  //       log('No image selected.');
  //     }
  //   } catch (e) {
  //     log('Error picking image: $e');
  //   }
  // }
  final ImagePicker _picker = ImagePicker();
  List<XFile> _chosenFiles = []; // List to store selected images

  List<XFile>? get chosenFiles => _chosenFiles;

  // Function to pick multiple images from the gallery
  Future<void> pickMultipleImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        log('Picked files count: ${pickedFiles.length}');
        _chosenFiles = pickedFiles;
        notifyListeners(); // Notify listeners to rebuild UI
      } else {
        log('No images selected.');
      }
    } catch (e) {
      log('Error picking images: $e');
    }
  }

  // Optional: Clear selected images
  void clearSelectedImages() {
    _chosenFiles = [];
    notifyListeners();
  }
}
