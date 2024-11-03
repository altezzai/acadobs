import 'dart:convert';

List<Duty> dutyFromJson(String str) =>
    List<Duty>.from(json.decode(str).map((x) => Duty.fromJson(x)));

String dutyToJson(List<Duty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Duty {
  int? id;
  String? dutyTitle;
  String? description;
  String? status;
  String? remark;
  String? fileAttachment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Duty({
    this.id,
    this.dutyTitle,
    this.description,
    this.status,
    this.remark,
    this.fileAttachment,
    this.createdAt,
    this.updatedAt,
  });

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        id: json["id"] as int?,
        dutyTitle: json["duty_title"] as String?,
        description: json["description"] as String?,
        status: json["status"] as String?,
        remark: json["remark"] as String?,
        fileAttachment: json["file_attachment"] as String?,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
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
