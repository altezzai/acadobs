// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'dart:convert';

List<Notice> noticeFromJson(String str) => List<Notice>.from(json.decode(str).map((x) => Notice.fromJson(x)));

String noticeToJson(List<Notice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notice {
    int? id;
    String? audienceType;
    String? noticeClass;
    String? division;
    DateTime? date;
    String? title;
    String? description;
    String? fileUpload;
    DateTime? createdAt;
    DateTime? updatedAt;

    Notice({
        this.id,
        this.audienceType,
        this.noticeClass,
        this.division,
        this.date,
        this.title,
        this.description,
        this.fileUpload,
        this.createdAt,
        this.updatedAt,
    });

    factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        id: json["id"],
        audienceType: json["audience_type"],
        noticeClass: json["class"],
        division: json["division"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        title: json["title"],
        description: json["description"],
        fileUpload: json["file_upload"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "audience_type": audienceType,
        "class": noticeClass,
        "division": division,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
        "file_upload": fileUpload,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
