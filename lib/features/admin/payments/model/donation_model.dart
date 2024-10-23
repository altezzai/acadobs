// To parse this JSON data, do
//
//     final donation = donationFromJson(jsonString);

import 'dart:convert';

List<Donation> donationFromJson(String str) =>
    List<Donation>.from(json.decode(str).map((x) => Donation.fromJson(x)));

String donationToJson(List<Donation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donation {
  int? id;
  int? donorId;
  String? amountDonated;
  DateTime? donationDate;
  String? purpose;
  String? donationType;
  String? paymentMethod;
  String? transactionId;
  String? receiptUpload;
  DateTime? createdAt;
  DateTime? updatedAt;

  Donation({
    this.id,
    this.donorId,
    this.amountDonated,
    this.donationDate,
    this.purpose,
    this.donationType,
    this.paymentMethod,
    this.transactionId,
    this.receiptUpload,
    this.createdAt,
    this.updatedAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        id: json["id"],
        donorId: json["donor_id"],
        amountDonated: json["amount_donated"],
        donationDate: json["donation_date"] == null
            ? null
            : DateTime.parse(json["donation_date"]),
        purpose: json["purpose"],
        donationType: json["donation_type"],
        paymentMethod: json["payment_method"],
        transactionId: json["transaction_id"],
        receiptUpload: json["receipt_upload"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "donor_id": donorId,
        "amount_donated": amountDonated,
        "donation_date":
            "${donationDate!.year.toString().padLeft(4, '0')}-${donationDate!.month.toString().padLeft(2, '0')}-${donationDate!.day.toString().padLeft(2, '0')}",
        "purpose": purpose,
        "donation_type": donationType,
        "payment_method": paymentMethod,
        "transaction_id": transactionId,
        "receipt_upload": receiptUpload,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
