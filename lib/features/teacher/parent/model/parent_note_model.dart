// To parse this JSON data, do
//
//     final parentNote = parentNoteFromJson(jsonString);

import 'dart:convert';

ParentNote parentNoteFromJson(String str) => ParentNote.fromJson(json.decode(str));

String parentNoteToJson(ParentNote data) => json.encode(data.toJson());

class ParentNote {
    String? status;
    ParentNoteData? data;

    ParentNote({
        this.status,
        this.data,
    });

    factory ParentNote.fromJson(Map<String, dynamic> json) => ParentNote(
        status: json["status"],
        data: json["data"] == null ? null : ParentNoteData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class ParentNoteData {
    int? id;
    int? teacherId;
    String? noteTitle;
    String? noteContent;
    dynamic noteAttachment;
    dynamic trash;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<ParentNoteStudentDetails>? ParentNoteStudents;

    ParentNoteData({
        this.id,
        this.teacherId,
        this.noteTitle,
        this.noteContent,
        this.noteAttachment,
        this.trash,
        this.createdAt,
        this.updatedAt,
        this.ParentNoteStudents,
    });

    factory ParentNoteData.fromJson(Map<String, dynamic> json) => ParentNoteData(
        id: json["id"],
        teacherId: json["teacher_id"],
        noteTitle: json["note_title"],
        noteContent: json["note_content"],
        noteAttachment: json["note_attachment"],
        trash: json["trash"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        ParentNoteStudents: json["parent_note_students"] == null ? [] : List<ParentNoteStudentDetails>.from(json["parent_note_students"]!.map((x) => ParentNoteStudentDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "note_title": noteTitle,
        "note_content": noteContent,
        "note_attachment": noteAttachment,
        "trash": trash,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "parent_note_students": ParentNoteStudents == null ? [] : List<dynamic>.from(ParentNoteStudents!.map((x) => x.toJson())),
    };
}

class ParentNoteStudentDetails {
    int? id;
    int? parentnoteId;
    int? studentId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? viewed;
    StudentDetails? student;

    ParentNoteStudentDetails({
        this.id,
        this.parentnoteId,
        this.studentId,
        this.createdAt,
        this.updatedAt,
        this.viewed,
        this.student,
    });

    factory ParentNoteStudentDetails.fromJson(Map<String, dynamic> json) => ParentNoteStudentDetails(
        id: json["id"],
        parentnoteId: json["parentnote_id"],
        studentId: json["student_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        viewed: json["viewed"],
        student: json["student"] == null ? null : StudentDetails.fromJson(json["student"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parentnote_id": parentnoteId,
        "student_id": studentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "viewed": viewed,
        "student": student?.toJson(),
    };
}

class StudentDetails {
    int? id;
    String? fullName;
    dynamic studentPhoto;

    StudentDetails({
        this.id,
        this.fullName,
        this.studentPhoto,
    });

    factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        id: json["id"],
        fullName: json["full_name"],
        studentPhoto: json["student_photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "student_photo": studentPhoto,
    };
}
