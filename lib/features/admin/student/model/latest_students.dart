// To parse this JSON data, do
//
//     final latestStudents = latestStudentsFromJson(jsonString);

import 'dart:convert';

List<LatestStudents> latestStudentsFromJson(String str) =>
    List<LatestStudents>.from(
        json.decode(str).map((x) => LatestStudents.fromJson(x)));

String latestStudentsToJson(List<LatestStudents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestStudents {
  int? id;
  String? fullName;
  String? studentPhoto;
  String? latestStudentClass;
  Section? section;

  LatestStudents({
    this.id,
    this.fullName,
    this.studentPhoto,
    this.latestStudentClass,
    this.section,
  });

  factory LatestStudents.fromJson(Map<String, dynamic> json) => LatestStudents(
        id: json["id"],
        fullName: json["full_name"],
        studentPhoto: json["student_photo"],
        latestStudentClass: json["class"],
        section: sectionValues.map[json["section"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "student_photo": studentPhoto,
        "class": latestStudentClass,
        "section": sectionValues.reverse[section],
      };
}

enum Section { A, B }

final sectionValues = EnumValues({"A": Section.A, "B": Section.B});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
