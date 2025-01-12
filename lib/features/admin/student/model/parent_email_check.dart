// To parse this JSON previousStudentData, do
//
//     final parentEmailCheck = parentEmailCheckFromJson(jsonString);

import 'dart:convert';

ParentEmailCheck parentEmailCheckFromJson(String str) => ParentEmailCheck.fromJson(json.decode(str));


class ParentEmailCheck {
    String? status;
    String? message;
    List<PreviousStudentData>? previousStudentData;

    ParentEmailCheck({
        this.status,
        this.message,
        this.previousStudentData,
    });

    factory ParentEmailCheck.fromJson(Map<String, dynamic> json) => ParentEmailCheck(
        status: json["status"],
        message: json["message"],
        previousStudentData: json["data"] == null ? [] : List<PreviousStudentData>.from(json["data"]!.map((x) => PreviousStudentData.fromJson(x))),
    );
}

class PreviousStudentData {
    int? studentId;
    String? studentName;
    String? fatherFullName;
    String? motherFullName;
    String? guardianFullName;
    String? fatherContactNumber;
    String? motherContactNumber;
    String? parentEmail;
    String? occupation;
    String? fatherAadhaarNumber;
    String? motherAadhaarNumber;
    String? alternateEmergencyContact;
    dynamic fatherMotherPhoto;

    PreviousStudentData({
        this.studentId,
        this.studentName,
        this.fatherFullName,
        this.motherFullName,
        this.guardianFullName,
        this.fatherContactNumber,
        this.motherContactNumber,
        this.parentEmail,
        this.occupation,
        this.fatherAadhaarNumber,
        this.motherAadhaarNumber,
        this.alternateEmergencyContact,
        this.fatherMotherPhoto,
    });

    factory PreviousStudentData.fromJson(Map<String, dynamic> json) => PreviousStudentData(
        studentId: json["student_id"],
        studentName: json["student_name"],
        fatherFullName: json["father_full_name"],
        motherFullName: json["mother_full_name"],
        guardianFullName: json["guardian_full_name"],
        fatherContactNumber: json["father_contact_number"],
        motherContactNumber: json["mother_contact_number"],
        parentEmail: json["parent_email"],
        occupation: json["occupation"],
        fatherAadhaarNumber: json["father_aadhaar_number"],
        motherAadhaarNumber: json["mother_aadhaar_number"],
        alternateEmergencyContact: json["alternate_emergency_contact"],
        fatherMotherPhoto: json["father_mother_photo"],
    );
}
