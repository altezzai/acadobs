// To parse this JSON data, do
//
//     final teacherDuties = teacherDutiesFromJson(jsonString);

import 'dart:convert';

TeacherDuties teacherDutiesFromJson(String str) =>
    TeacherDuties.fromJson(json.decode(str));

String teacherDutiesToJson(TeacherDuties data) => json.encode(data.toJson());

class TeacherDuties {
  String? status;
  List<DutyItem>? duties;

  TeacherDuties({
    this.status,
    this.duties,
  });

  factory TeacherDuties.fromJson(Map<String, dynamic> json) => TeacherDuties(
        status: json["status"],
        duties: json["duties"] == null
            ? []
            : List<DutyItem>.from(
                json["duties"]!.map((x) => DutyItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "duties": duties == null
            ? []
            : List<dynamic>.from(duties!.map((x) => x.toJson())),
      };
}

class DutyItem {
  int? id;
  int? dutyId;
  int? teacherId;
  DateTime? assignedDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? dutyTitle;
  String? description;
  String? fileAttachment;
  String? status;
  String? remark;

  DutyItem({
    this.id,
    this.dutyId,
    this.teacherId,
    this.assignedDate,
    this.createdAt,
    this.updatedAt,
    this.dutyTitle,
    this.description,
    this.fileAttachment,
    this.status,
    this.remark,
  });

  factory DutyItem.fromJson(Map<String, dynamic> json) => DutyItem(
        id: json["id"],
        dutyId: json["duty_id"],
        teacherId: json["teacher_id"],
        assignedDate: json["assigned_date"] == null
            ? null
            : DateTime.parse(json["assigned_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        dutyTitle: json["duty_title"],
        description: json["description"],
        fileAttachment: json["file_attachment"],
        status: json["status"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duty_id": dutyId,
        "teacher_id": teacherId,
        "assigned_date": assignedDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "duty_title": dutyTitle,
        "description": description,
        "file_attachment": fileAttachment,
        "status": status,
        "remark": remark,
      };
}
