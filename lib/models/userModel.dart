// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? docId;
  final String? userName;
  final String? userImage;
  final String? userEmail;
  final int? createdAt;

  UserModel({
    this.docId,
    this.userName,
    this.userImage,
    this.userEmail,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    userName: json["userName"],
    userImage: json["userImage"],
    userEmail: json["userEmail"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "userName": userName,
    "userImage": userImage,
    "userEmail": userEmail,
    "createdAt": createdAt,
  };
}
