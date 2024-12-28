import 'dart:convert'; // For JSON encoding/decoding

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage();

  // Keys for secure storage
  static const _tokenKey = 'token';
  static const _userKey = 'user';
  static const _teacherKey = 'teacher';
  static const _studentKey = 'student';

  /// Save data to secure storage
  static Future<void> saveTokenAndUserData(Map<String, dynamic> data) async {
    await _storage.write(key: _tokenKey, value: data['token']);
    await _storage.write(key: _userKey, value: jsonEncode(data['user']));
  }

  /// Retrieve token from secure storage
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Retrieve user data from secure storage
  static Future<Map<String, dynamic>?> getUser() async {
    final userData = await _storage.read(key: _userKey);
    if (userData != null) {
      return jsonDecode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  /// *****Get individual user details*****
  // Get userid
  static Future<int> getUserId() async {
    final user = await getUser();
    return user?['user_id'];
  }

// Get usermail
  static Future<String?> getUserEmail() async {
    final user = await getUser();
    return user?['email'];
  }

// Get usertype
  static Future<String?> getUserType() async {
    final user = await getUser();
    return user?['user_type'];
  }

  /// Get chatId
  static Future<int?> getChatId() async {
    final user = await getUser();
    return user?['id'];
  }

  /// Delete all stored data
  static Future<void> clearSecureStorage() async {
    await _storage.deleteAll();
  }

  /// Save teacher data
  static Future<void> saveTeacherData(Map<String, dynamic> teacherData) async {
    await _storage.write(key: _teacherKey, value: jsonEncode(teacherData));
  }

  // Save student data
  static Future<void> saveStudentData(Map<String, dynamic> studentData) async {
    await _storage.write(key: _studentKey, value: jsonEncode(studentData));
  }

  /// Retrieve teacher data
  static Future<Map<String, dynamic>?> getTeacherData() async {
    final teacherData = await _storage.read(key: _teacherKey);
    if (teacherData != null) {
      return jsonDecode(teacherData) as Map<String, dynamic>;
    }
    return null;
  }

  // Retrieve student data
  static Future<Map<String, dynamic>?> getStudentData() async {
    final studentData = await _storage.read(key: _studentKey);
    if (studentData != null) {
      return jsonDecode(studentData) as Map<String, dynamic>;
    }
    return null;
  }

  /// Get individual teacher details
  static Future<int?> getTeacherId() async {
    final teacher = await getTeacherData();
    return teacher?['id'];
  }

  static Future<String?> getTeacherEmail() async {
    final teacher = await getTeacherData();
    return teacher?['email_address'];
  }

  static Future<String?> getTeacherName() async {
    final teacher = await getTeacherData();
    return teacher?['full_name'];
  }

  /// Get teacher profile photo
  static Future<String?> getTeacherProfilePhoto() async {
    final teacher = await getTeacherData();
    return teacher?['profile_photo'];
  }

  // Get individual student details
  static Future<int?> getStudentId() async {
    final student = await getStudentData();
    return student?['id'];
  }

  static Future<String?> getParentEmail() async {
    final student = await getStudentData();
    return student?['parent_email'];
  }

  static Future<String?> getParentName() async {
    final student = await getStudentData();
    return student?['guardian_full_name'];
  }

  /// Get parent profile photo
  static Future<String?> getParentProfilePhoto() async {
    final student = await getStudentData();
    return student?['father_mother_photo'];
  }

  /// Delete teacher data
  static Future<void> clearTeacherData() async {
    await _storage.delete(key: _teacherKey);
  }

  // Delete student data
  static Future<void> clearStudentData() async {
    await _storage.delete(key: _studentKey);
  }
}
