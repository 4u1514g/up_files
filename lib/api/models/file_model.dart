// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

List<FileModel> fileModelFromJson(String str) => List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String fileModelToJson(List<FileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  FileModel({
    this.idUser,
    this.name,
  });

  String? idUser;
  String? name;

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    idUser: json["id_user"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "name": name,
  };
}
