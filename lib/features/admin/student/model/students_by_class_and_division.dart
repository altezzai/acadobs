import 'dart:convert';

StudentsByClassAndDivision studentsByClassAndDivisionFromJson(String str) => StudentsByClassAndDivision.fromJson(json.decode(str));

String studentsByClassAndDivisionToJson(StudentsByClassAndDivision data) => json.encode(data.toJson());

class StudentsByClassAndDivision {
    String? status;
    Students? students;

    StudentsByClassAndDivision({
        this.status,
        this.students,
    });

    factory StudentsByClassAndDivision.fromJson(Map<String, dynamic> json) => StudentsByClassAndDivision(
        status: json["status"],
        students: json["students"] == null ? null : Students.fromJson(json["students"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "students": students?.toJson(),
    };
}

class Students {
    int? currentPage;
    List<StudentProfile>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    String? prevPageUrl;
    int? to;
    int? total;

    Students({
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

    factory Students.fromJson(Map<String, dynamic> json) => Students(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<StudentProfile>.from(json["data"].map((x) => StudentProfile.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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

class StudentProfile {
    int? id;
    String? fullName;
    dynamic studentPhoto;
    String? className;
    String? section;

    StudentProfile({
        this.id,
        this.fullName,
        this.studentPhoto,
        this.className,
        this.section,
    });

    factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
        id: json["id"],
        fullName: json["full_name"],
        studentPhoto: json["student_photo"],
        className: json["class"],
        section: json["section"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "student_photo": studentPhoto,
        "class": className,
        "section": section,
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
