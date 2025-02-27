// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
    String? status;
    List<ActivityElement>? activities;

    Activity({
        this.status,
        this.activities,
    });

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        status: json["status"],
        activities: json["activities"] == null ? [] : List<ActivityElement>.from(json["activities"]!.map((x) => ActivityElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    };
}

class ActivityElement {
    DateTime? date;
    String? classGrade;
    String? section;
    int? periodNumber;
    String? subjectName;

    ActivityElement({
        this.date,
        this.classGrade,
        this.section,
        this.periodNumber,
        this.subjectName,
    });

    factory ActivityElement.fromJson(Map<String, dynamic> json) => ActivityElement(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        classGrade: json["class_grade"],
        section: json["section"],
        periodNumber: json["period_number"],
        subjectName: json["subject_name"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "class_grade": classGrade,
        "section": section,
        "period_number": periodNumber,
        "subject_name": subjectName,
    };
}
