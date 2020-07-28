// To parse this JSON data, do
//
//     final modelKategori = modelKategoriFromJson(jsonString);

import 'dart:convert';

ModelKategori modelKategoriFromJson(String str) => ModelKategori.fromJson(json.decode(str));

String modelKategoriToJson(ModelKategori data) => json.encode(data.toJson());

class ModelKategori {
  ModelKategori({
    this.status,
    this.message,
    this.kategori,
  });

  int status;
  String message;
  List<Kategori> kategori;

  factory ModelKategori.fromJson(Map<String, dynamic> json) => ModelKategori(
    status: json["status"],
    message: json["message"],
    kategori: List<Kategori>.from(json["kategori"].map((x) => Kategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "kategori": List<dynamic>.from(kategori.map((x) => x.toJson())),
  };
}

class Kategori {
  Kategori({
    this.idKategori,
    this.namaKategori,
    this.images,
  });

  String idKategori;
  String namaKategori;
  String images;

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
    idKategori: json["id_kategori"],
    namaKategori: json["nama_kategori"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id_kategori": idKategori,
    "nama_kategori": namaKategori,
    "images": images,
  };
}
