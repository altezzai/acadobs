// To parse this JSON data, do
//
//     final duty = dutyFromJson(jsonString);

import 'dart:convert';

Duty dutyFromJson(String str) => Duty.fromJson(json.decode(str));

String dutyToJson(Duty data) => json.encode(data.toJson());

class Duty {
  DutyClass? duty;
  List<AssignedTeacher>? assignedTeachers;

  Duty({
    this.duty,
    this.assignedTeachers,
  });

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        duty: json["duty"] == null ? null : DutyClass.fromJson(json["duty"]),
        assignedTeachers: json["assigned_teachers"] == null
            ? []
            : List<AssignedTeacher>.from(json["assigned_teachers"]!
                .map((x) => AssignedTeacher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "duty": duty?.toJson(),
        "assigned_teachers": assignedTeachers == null
            ? []
            : List<dynamic>.from(assignedTeachers!.map((x) => x.toJson())),
      };
}

class AssignedTeacher {
  int? id;
  String? fullName;
  String? contactNumber;
  String? emailAddress;
  String? currentDesignation;
  String? subjectsTaught;
  String? classGradeHandling;
  String? administrativeRoles;
  String? profilePhoto;

  AssignedTeacher({
    this.id,
    this.fullName,
    this.contactNumber,
    this.emailAddress,
    this.currentDesignation,
    this.subjectsTaught,
    this.classGradeHandling,
    this.administrativeRoles,
    this.profilePhoto,
  });

  factory AssignedTeacher.fromJson(Map<String, dynamic> json) =>
      AssignedTeacher(
        id: json["id"],
        fullName: json["full_name"],
        contactNumber: json["contact_number"],
        emailAddress: json["email_address"],
        currentDesignation: json["current_designation"],
        subjectsTaught: json["subjects_taught"],
        classGradeHandling: json["class_grade_handling"],
        administrativeRoles: json["administrative_roles"],
        profilePhoto: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "contact_number": contactNumber,
        "email_address": emailAddress,
        "current_designation": currentDesignation,
        "subjects_taught": subjectsTaught,
        "class_grade_handling": classGradeHandling,
        "administrative_roles": administrativeRoles,
        "profile_photo": profilePhoto,
      };
}

class DutyClass {
  int? id;
  String? dutyTitle;
  String? description;
  String? status;
  String? remark;
  String? fileAttachment;
  DateTime? createdAt;
  DateTime? updatedAt;

  DutyClass({
    this.id,
    this.dutyTitle,
    this.description,
    this.status,
    this.remark,
    this.fileAttachment,
    this.createdAt,
    this.updatedAt,
  });

  factory DutyClass.fromJson(Map<String, dynamic> json) => DutyClass(
        id: json["id"],
        dutyTitle: json["duty_title"],
        description: json["description"],
        status: json["status"],
        remark: json["remark"],
        fileAttachment: json["file_attachment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duty_title": dutyTitle,
        "description": description,
        "status": status,
        "remark": remark,
        "file_attachment": fileAttachment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
