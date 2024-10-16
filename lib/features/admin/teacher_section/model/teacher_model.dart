// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

List<Teacher> teacherFromJson(String str) =>
    List<Teacher>.from(json.decode(str).map((x) => Teacher.fromJson(x)));

String teacherToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
  int? id;
  String? fullName;
  DateTime? dateOfBirth;
  Gender? gender;
  Address? address;
  String? contactNumber;
  String? emailAddress;
  String? aadhaarNumber;
  String? bloodGroup;
  Nationality? nationality;
  MaritalStatus? maritalStatus;
  String? highestQualification;
  String? additionalQualifications;
  String? specializationSubjectExpertise;
  int? totalExperience;
  String? previousSchools;
  int? experienceInCbseCurriculum;
  String? classLevelsTaught;
  DateTime? dateOfJoining;
  String? currentDesignation;
  String? subjectsTaught;
  String? classGradeHandling;
  String? salary;
  String? awardsRecognitions;
  String? languagesSpoken;
  String? extracurricularActivities;
  String? administrativeRoles;
  String? profilePhoto;
  String? aadhaarDocument;
  String? qualificationCertificates;
  String? experienceCertificates;
  dynamic status;
  dynamic trash;
  DateTime? createdAt;
  DateTime? updatedAt;

  Teacher({
    this.id,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.contactNumber,
    this.emailAddress,
    this.aadhaarNumber,
    this.bloodGroup,
    this.nationality,
    this.maritalStatus,
    this.highestQualification,
    this.additionalQualifications,
    this.specializationSubjectExpertise,
    this.totalExperience,
    this.previousSchools,
    this.experienceInCbseCurriculum,
    this.classLevelsTaught,
    this.dateOfJoining,
    this.currentDesignation,
    this.subjectsTaught,
    this.classGradeHandling,
    this.salary,
    this.awardsRecognitions,
    this.languagesSpoken,
    this.extracurricularActivities,
    this.administrativeRoles,
    this.profilePhoto,
    this.aadhaarDocument,
    this.qualificationCertificates,
    this.experienceCertificates,
    this.status,
    this.trash,
    this.createdAt,
    this.updatedAt,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        fullName: json["full_name"],
        dateOfBirth: json["date_of_birth"] != null
            ? DateTime.tryParse(json["date_of_birth"])
            : null,

        // gender: genderValues.map[json["gender"]]!,
        // address: addressValues.map[json["address"]]!,
        gender:
            json["gender"] != null ? genderValues.map[json["gender"]] : null,
        address:
            json["address"] != null ? addressValues.map[json["address"]] : null,

        contactNumber: json["contact_number"],
        emailAddress: json["email_address"],
        aadhaarNumber: json["aadhaar_number"],
        bloodGroup: json["blood_group"],
        nationality: json["nationality"] != null
            ? nationalityValues.map[json["nationality"]]
            : null,
        maritalStatus: json["marital_status"] != null
            ? maritalStatusValues.map[json["marital_status"]]
            : null,

        highestQualification: json["highest_qualification"],
        additionalQualifications: json["additional_qualifications"],
        specializationSubjectExpertise:
            json["specialization_subject_expertise"],
        totalExperience: json["total_experience"],
        previousSchools: json["previous_schools"],
        experienceInCbseCurriculum: json["experience_in_cbse_curriculum"],
        classLevelsTaught: json["class_levels_taught"],
        dateOfJoining: json["date_of_joining"] == null
            ? null
            : DateTime.parse(json["date_of_joining"]),
        currentDesignation: json["current_designation"],
        subjectsTaught: json["subjects_taught"],
        classGradeHandling: json["class_grade_handling"],
        salary: json["salary"],
        awardsRecognitions: json["awards_recognitions"],
        languagesSpoken: json["languages_spoken"],
        extracurricularActivities: json["extracurricular_activities"],
        administrativeRoles: json["administrative_roles"],
        profilePhoto: json["profile_photo"],
        aadhaarDocument: json["aadhaar_document"],
        qualificationCertificates: json["qualification_certificates"],
        experienceCertificates: json["experience_certificates"],
        status: json["status"],
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
        "gender": genderValues.reverse[gender],
        "address": addressValues.reverse[address],
        "contact_number": contactNumber,
        "email_address": emailAddress,
        "aadhaar_number": aadhaarNumber,
        "blood_group": bloodGroup,
        "nationality": nationalityValues.reverse[nationality],
        "marital_status": maritalStatusValues.reverse[maritalStatus],
        "highest_qualification": highestQualification,
        "additional_qualifications": additionalQualifications,
        "specialization_subject_expertise": specializationSubjectExpertise,
        "total_experience": totalExperience,
        "previous_schools": previousSchools,
        "experience_in_cbse_curriculum": experienceInCbseCurriculum,
        "class_levels_taught": classLevelsTaught,
        "date_of_joining":
            "${dateOfJoining!.year.toString().padLeft(4, '0')}-${dateOfJoining!.month.toString().padLeft(2, '0')}-${dateOfJoining!.day.toString().padLeft(2, '0')}",
        "current_designation": currentDesignation,
        "subjects_taught": subjectsTaught,
        "class_grade_handling": classGradeHandling,
        "salary": salary,
        "awards_recognitions": awardsRecognitions,
        "languages_spoken": languagesSpoken,
        "extracurricular_activities": extracurricularActivities,
        "administrative_roles": administrativeRoles,
        "profile_photo": profilePhoto,
        "aadhaar_document": aadhaarDocument,
        "qualification_certificates": qualificationCertificates,
        "experience_certificates": experienceCertificates,
        "status": status,
        "trash": trash,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Address { THE_123_ELM_STREET_SPRINGFIELD, THE_123_STREET }

final addressValues = EnumValues({
  "123 Elm Street, Springfield": Address.THE_123_ELM_STREET_SPRINGFIELD,
  "123 street": Address.THE_123_STREET
});

enum Gender { MALE }

final genderValues = EnumValues({"Male": Gender.MALE});

enum MaritalStatus { MARRIED }

final maritalStatusValues = EnumValues({"Married": MaritalStatus.MARRIED});

enum Nationality { INDIA }

final nationalityValues = EnumValues({"India": Nationality.INDIA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
