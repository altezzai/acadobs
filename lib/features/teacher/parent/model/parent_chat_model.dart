// To parse this JSON data, do
//
//     final parentChat = parentChatFromJson(jsonString);

import 'dart:convert';

ParentChat parentChatFromJson(String str) => ParentChat.fromJson(json.decode(str));


class ParentChat {
    int? id;
    int? parentNoteId;
    int? senderId;
    int? receiverId;
    String? message;
    String? senderRole;
    DateTime? messageTimestamp;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? viewed;

    ParentChat({
        this.id,
        this.parentNoteId,
        this.senderId,
        this.receiverId,
        this.message,
        this.senderRole,
        this.messageTimestamp,
        this.createdAt,
        this.updatedAt,
        this.viewed,
    });

    factory ParentChat.fromJson(Map<String, dynamic> json) => ParentChat(
        id: json["id"],
        parentNoteId: json["parent_note_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        senderRole: json["sender_role"],
        messageTimestamp: json["message_timestamp"] == null ? null : DateTime.parse(json["message_timestamp"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        viewed: json["viewed"],
    );
}
