// To parse this JSON data, do
//
//     final studentData = studentDataFromJson(jsonString);

import 'dart:convert';

List<StudentData> studentDataFromJson(String str) => List<StudentData>.from(
    json.decode(str).map((x) => StudentData.fromJson(x)));

String studentDataToJson(List<StudentData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentData {
  int? id;
  String? fullName;
  DateTime? dateOfBirth;
  String? gender;
  String? studentDatumClass;
  String? section;
  int? rollNumber;
  String? admissionNumber;
  String? aadhaarNumber;
  String? bloodGroup;
  String? residentialAddress;
  String? contactNumber;
  String? email;
  String? previousSchool;
  String? fatherFullName;
  String? motherFullName;
  dynamic guardianFullName;
  String? fatherContactNumber;
  String? motherContactNumber;
  String? parentEmail;
  String? occupation;
  String? fatherAadhaarNumber;
  String? motherAadhaarNumber;
  String? alternateEmergencyContact;
  String? category;
  String? siblingInformation;
  int? transportRequirement;
  int? hostelRequirement;
  dynamic studentPhoto;
  String? fatherMotherPhoto;
  String? aadhaarCard;
  String? previousSchoolTc;
  String? birthCertificate;
  dynamic insertedUserId;
  dynamic trash;
  DateTime? createdAt;
  DateTime? updatedAt;

  StudentData({
    this.id,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.studentDatumClass,
    this.section,
    this.rollNumber,
    this.admissionNumber,
    this.aadhaarNumber,
    this.bloodGroup,
    this.residentialAddress,
    this.contactNumber,
    this.email,
    this.previousSchool,
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
    this.category,
    this.siblingInformation,
    this.transportRequirement,
    this.hostelRequirement,
    this.studentPhoto,
    this.fatherMotherPhoto,
    this.aadhaarCard,
    this.previousSchoolTc,
    this.birthCertificate,
    this.insertedUserId,
    this.trash,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        id: json["id"],
        fullName: json["full_name"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        studentDatumClass: json["class"],
        section: json["section"],
        rollNumber: json["roll_number"],
        admissionNumber: json["admission_number"],
        aadhaarNumber: json["aadhaar_number"],
        bloodGroup: json["blood_group"],
        residentialAddress: json["residential_address"],
        contactNumber: json["contact_number"],
        email: json["email"],
        previousSchool: json["previous_school"],
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
        category: json["category"],
        siblingInformation: json["sibling_information"],
        transportRequirement: json["transport_requirement"],
        hostelRequirement: json["hostel_requirement"],
        studentPhoto: json["student_photo"],
        fatherMotherPhoto: json["father_mother_photo"],
        aadhaarCard: json["aadhaar_card"],
        previousSchoolTc: json["previous_school_tc"],
        birthCertificate: json["birth_certificate"],
        insertedUserId: json["inserted_user_id"],
        trash: json["trash"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "class": studentDatumClass,
        "section": section,
        "roll_number": rollNumber,
        "admission_number": admissionNumber,
        "aadhaar_number": aadhaarNumber,
        "blood_group": bloodGroup,
        "residential_address": residentialAddress,
        "contact_number": contactNumber,
        "email": email,
        "previous_school": previousSchool,
        "father_full_name": fatherFullName,
        "mother_full_name": motherFullName,
        "guardian_full_name": guardianFullName,
        "father_contact_number": fatherContactNumber,
        "mother_contact_number": motherContactNumber,
        "parent_email": parentEmail,
        "occupation": occupation,
        "father_aadhaar_number": fatherAadhaarNumber,
        "mother_aadhaar_number": motherAadhaarNumber,
        "alternate_emergency_contact": alternateEmergencyContact,
        "category": category,
        "sibling_information": siblingInformation,
        "transport_requirement": transportRequirement,
        "hostel_requirement": hostelRequirement,
        "student_photo": studentPhoto,
        "father_mother_photo": fatherMotherPhoto,
        "aadhaar_card": aadhaarCard,
        "previous_school_tc": previousSchoolTc,
        "birth_certificate": birthCertificate,
        "inserted_user_id": insertedUserId,
        "trash": trash,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
