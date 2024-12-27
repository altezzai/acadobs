// To parse this JSON data, do
//
//     final parentNoteStudent = parentNoteStudentFromJson(jsonString);

import 'dart:convert';

ParentNoteStudent parentNoteStudentFromJson(String str) => ParentNoteStudent.fromJson(json.decode(str));


class ParentNoteStudent {
    String? status;
    List<NoteData>? data;

    ParentNoteStudent({
        this.status,
        this.data,
    });

    factory ParentNoteStudent.fromJson(Map<String, dynamic> json) => ParentNoteStudent(
        status: json["status"],
        data: json["data"] == null ? [] : List<NoteData>.from(json["data"]!.map((x) => NoteData.fromJson(x))),
    );

}

class NoteData {
    int id;
    String? noteTitle;
    String? noteContent;
    dynamic noteAttachment;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? teacherId;
    String? teacherName;
    String? teacherProfilePhoto;
    int? viewed;

    NoteData({
        required this.id,
        this.noteTitle,
        this.noteContent,
        this.noteAttachment,
        this.createdAt,
        this.updatedAt,
        this.teacherId,
        this.teacherName,
        this.teacherProfilePhoto,
        this.viewed,
    });

    factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
        id: json["id"],
        noteTitle: json["note_title"],
        noteContent: json["note_content"],
        noteAttachment: json["note_attachment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        teacherId: json["teacher_id"],
        teacherName: json["teacher_name"],
        teacherProfilePhoto: json["teacher_profile_photo"],
        viewed: json["viewed"],
    );
}
