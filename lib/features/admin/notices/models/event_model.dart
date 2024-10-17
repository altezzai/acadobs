// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    int? id;
    String? title;
    String? description;
    DateTime? eventDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<dynamic>? images;

    Event({
        this.id,
        this.title,
        this.description,
        this.eventDate,
        this.createdAt,
        this.updatedAt,
        this.images,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        eventDate: json["event_date"] == null ? null : DateTime.parse(json["event_date"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "event_date": "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    };
}
