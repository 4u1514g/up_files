// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.phone,
    this.password,
    this.name,
  });

  static UserModel? savedAccount;
  String? id;
  String? phone;
  String? password;
  String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    phone: json["phone"],
    password: json["password"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "password": password,
    "name": name,
  };
}
