// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    int? currentPage;
    List<Payment>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    PaymentModel({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Payment>.from(json["data"]!.map((x) => Payment.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Payment {
    int? id;
    int? studentId;
    int? recordedBy;
    String? amountPaid;
    DateTime? paymentDate;
    String? month;
    String? year;
    String? paymentMethod;
    dynamic transactionId;
    String? paymentStatus;
    dynamic fileUpload;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? fullName;
    String? datumClass;
    String? section;
    String? studentPhoto;

    Payment({
        this.id,
        this.studentId,
        this.recordedBy,
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
        this.datumClass,
        this.section,
        this.studentPhoto,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        studentId: json["student_id"],
        recordedBy: json["recorded_by"],
        amountPaid: json["amount_paid"],
        paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
        month: json["month"],
        year: json["year"],
        paymentMethod: json["payment_method"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        fileUpload: json["file_upload"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        datumClass: json["class"],
        section: json["section"],
        studentPhoto: json["student_photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "recorded_by": recordedBy,
        "amount_paid": amountPaid,
        "payment_date": "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "month": month,
        "year": year,
        "payment_method": paymentMethod,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "file_upload": fileUpload,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "class": datumClass,
        "section": section,
        "student_photo": studentPhoto,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
