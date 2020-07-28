// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    this.status,
    this.message,
    this.user,
  });

  int status;
  String message;
  List<User> user;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    status: json["status"],
    message: json["message"],
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.idUser,
    this.namaUser,
    this.email,
    this.notelp,
    this.photoUser,
    this.password,
  });

  String idUser;
  String namaUser;
  String email;
  String notelp;
  String photoUser;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    namaUser: json["nama_user"],
    email: json["email"],
    notelp: json["notelp"],
    photoUser: json["photo_user"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nama_user": namaUser,
    "email": email,
    "notelp": notelp,
    "photo_user": photoUser,
    "password": password,
  };
}
