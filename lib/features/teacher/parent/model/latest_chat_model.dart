// To parse this JSON data, do
//
//     final latestChat = latestChatFromJson(jsonString);

import 'dart:convert';

LatestChat latestChatFromJson(String str) => LatestChat.fromJson(json.decode(str));

String latestChatToJson(LatestChat data) => json.encode(data.toJson());

class LatestChat {
    int? id;
    int parentNoteId;
    int senderId;
    int receiverId;
    String? message;
    String? senderRole;
    int? studentId;
    DateTime? createdAt;
    int? userId;
    String? parentName;
    String? teacherName;

    LatestChat({
        this.id,
        required this.parentNoteId,
       required  this.senderId,
       required this.receiverId,
        this.message,
        this.senderRole,
        this.studentId,
        this.createdAt,
        this.userId,
        this.parentName,
        this.teacherName,
    });

    factory LatestChat.fromJson(Map<String, dynamic> json) => LatestChat(
        id: json["id"],
        parentNoteId: json["parent_note_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        senderRole: json["sender_role"],
        studentId: json["student_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        parentName: json["parent_name"],
        teacherName: json["teacher_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_note_id": parentNoteId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "sender_role": senderRole,
        "student_id": studentId,
        "created_at": createdAt?.toIso8601String(),
        "user_id": userId,
        "parent_name": parentName,
        "teacher_name": teacherName,
    };
}
