// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  int? eventId;
  String? title;
  String? description;
  DateTime? eventDate;
  DateTime? createdAt;
  List<EventImage>? images;

  Event({
    this.eventId,
    this.title,
    this.description,
    this.eventDate,
    this.createdAt,
    this.images,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"],
        title: json["title"],
        description: json["description"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        images: json["images"] == null
            ? []
            : List<EventImage>.from(json["images"]!.map((x) => EventImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "title": title,
        "description": description,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class EventImage {
  int? imageId;
  String? imagePath;

  EventImage({
    this.imageId,
    this.imagePath,
  });

  factory EventImage.fromJson(Map<String, dynamic> json) => EventImage(
        imageId: json["image_id"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image_path": imagePath,
      };
}
