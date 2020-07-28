// To parse this JSON data, do
//
//     final modelBeritaKategori = modelBeritaKategoriFromJson(jsonString);

import 'dart:convert';

ModelBeritaKategori modelBeritaKategoriFromJson(String str) => ModelBeritaKategori.fromJson(json.decode(str));

String modelBeritaKategoriToJson(ModelBeritaKategori data) => json.encode(data.toJson());

class ModelBeritaKategori {
  ModelBeritaKategori({
    this.message,
    this.status,
    this.beritakategori,
  });

  String message;
  int status;
  List<Beritakategori> beritakategori;

  factory ModelBeritaKategori.fromJson(Map<String, dynamic> json) => ModelBeritaKategori(
    message: json["message"],
    status: json["status"],
    beritakategori: List<Beritakategori>.from(json["beritakategori"].map((x) => Beritakategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "beritakategori": List<dynamic>.from(beritakategori.map((x) => x.toJson())),
  };
}

class Beritakategori {
  Beritakategori({
    this.idBerita,
    this.judulBerita,
    this.deskripsi,
    this.idKategori,
    this.idUser,
    this.createdAt,
    this.imagesBerita,
    this.namaKategori,
    this.images,
    this.namaUser,
    this.email,
    this.notelp,
    this.photoUser,
    this.password,
  });

  String idBerita;
  String judulBerita;
  String deskripsi;
  String idKategori;
  String idUser;
  DateTime createdAt;
  String imagesBerita;
  String namaKategori;
  String images;
  String namaUser;
  String email;
  String notelp;
  String photoUser;
  String password;

  factory Beritakategori.fromJson(Map<String, dynamic> json) => Beritakategori(
    idBerita: json["id_berita"],
    judulBerita: json["judul_berita"],
    deskripsi: json["deskripsi"],
    idKategori: json["id_kategori"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    imagesBerita: json["images_berita"],
    namaKategori: json["nama_kategori"],
    images: json["images"],
    namaUser: json["nama_user"],
    email: json["email"],
    notelp: json["notelp"],
    photoUser: json["photo_user"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id_berita": idBerita,
    "judul_berita": judulBerita,
    "deskripsi": deskripsi,
    "id_kategori": idKategori,
    "id_user": idUser,
    "created_at": createdAt.toIso8601String(),
    "images_berita": imagesBerita,
    "nama_kategori": namaKategori,
    "images": images,
    "nama_user": namaUser,
    "email": email,
    "notelp": notelp,
    "photo_user": photoUser,
    "password": password,
  };
}
