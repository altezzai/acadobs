// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  int? id;
  int? userId;
  String? amountPaid;
  DateTime? paymentDate;
  String? month;
  String? year;
  String? paymentMethod;
  String? transactionId;
  String? paymentStatus;
  dynamic fileUpload;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? paymentClass;
  String? section;
  dynamic studentPhoto;

  Payment({
    this.id,
    this.userId,
    this.amountPaid,
    this.paymentDate,
    this.month,
    this.year,
    this.paymentMethod,
    this.transactionId,
    this.paymentStatus,
    this.fileUpload,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.paymentClass,
    this.section,
    this.studentPhoto,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["student_id"],
        amountPaid: json["amount_paid"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        month: json["month"],
        year: json["year"],
        paymentMethod: json["payment_method"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        fileUpload: json["file_upload"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        paymentClass: json["class"],
        section: json["section"],
        studentPhoto: json["student_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount_paid": amountPaid,
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "month": month,
        "year": year,
        "payment_method": paymentMethod,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "file_upload": fileUpload,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "class": paymentClass,
        "section": section,
        "student_photo": studentPhoto,
      };
}
