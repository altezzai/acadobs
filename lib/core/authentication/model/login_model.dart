// // To parse this JSON data, do
// //
// //     final loginModel = loginModelFromJson(jsonString);

// import 'dart:convert';

// LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// class LoginModel {
//     String? token;
//     User? user;

//     LoginModel({
//         this.token,
//         this.user,
//     });

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         token: json["token"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "token": token,
//         "user": user?.toJson(),
//     };
// }

// class User {
//     int? id;
//     String? name;
//     String? email;
//     String? userType;
//     int? userId;

//     User({
//         this.id,
//         this.name,
//         this.email,
//         this.userType,
//         this.userId,
//     });

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         userType: json["user_type"],
//         userId: json["user_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "user_type": userType,
//         "user_id": userId,
//     };
// }
