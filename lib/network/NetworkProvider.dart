import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelBerita.dart';
import 'package:portal_news/model/ModelBeritaKategori.dart';
import 'package:portal_news/model/ModelKategori.dart';
import 'package:portal_news/model/ModelUser.dart';
import 'package:portal_news/ui/DashboardPage.dart';
import 'package:portal_news/ui/LoginRegister/LoginPage.dart';

abstract class BaseEndpoint{
  void registerUser(String myName, String myEmail, String myTelp, String myPassword, BuildContext context); //method dengan paramater
  Future<List>loginUser(String myEmail, String myPassword, BuildContext context);
  Future<List> getKategori();
  Future<List> getBerita(String myId);
  Future<List> getBeritaByIdKategori(String idKategori);
  void deleteBerita(String idBerita);
  void sendNotification(String urlImage);
  void addNews(String judul,  String deskripsi, File image, String idUser, String idKategori);
  void updateBerita(String idBerita, String myJudul, String myDeskripsi, String idKategori);
}

class NetworkProvider extends BaseEndpoint{

  @override
  void registerUser(String myName, String myEmail, String myTelp, String myPassword, BuildContext context) async{
    // TODO: implement registerUser

    final response = await http.post(ConstantFile().baseUrl+"registerUser", body: {
      'nama_user' : myName,
      'email': myEmail,
      'notelp' : myTelp,
      'password' : myPassword,

    });
    var listData = jsonDecode(response.body);
    if(listData['status'] == 200){
      print(listData['message']);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Information Register',
          desc: listData['message'],
          btnOkText: "Go to Login",
          btnOkOnPress: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()
            ));
          }
      ).show();
    }else{
      print(listData['message']);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Information Register',
          desc: listData['message'],
          btnOkOnPress: (){}
      ).show();
    }
  }

  @override
  Future<List> loginUser(String myEmail, myPassword, BuildContext context) async {
    // TODO: implement loginUser

    final response = await http.post(ConstantFile().baseUrl+"loginUser", body: {
      'email': myEmail,
      'password' : myPassword,
    });

    ModelUser listData = modelUserFromJson(response.body);
    if(listData.status == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()
      ));
      return listData.user;
    } else{
      print(listData.message);
      return null;
    }
  }

  @override
  Future<List> getKategori() async {
    // TODO: implement getKategori
    final response = await http.post(ConstantFile().baseUrl + "getKategori", body: {

    });
    ModelKategori listData = modelKategoriFromJson(response.body);
    return listData.kategori;
  }

  @override
  Future<List> getBerita(String myId) async{
    // TODO: implement getBerita
    final response = await http.post(ConstantFile().baseUrl + "getBerita", body: {
      'iduser' : myId
    });

    ModelBerita listData = modelBeritaFromJson(response.body);
    return listData.berita;
  }

  @override
  Future<List> getBeritaByIdKategori(String idKategori) async {
    // TODO: implement getBeritaByIdKategori
    final response = await http.post(ConstantFile().baseUrl + "getBeritaByIdKategori", body: {
      'id_kategori' : idKategori
    });

    ModelBeritaKategori listData = modelBeritaKategoriFromJson(response.body);
    return listData.beritakategori;
  }

  @override
  void deleteBerita(String idBerita) async{
    // TODO: implement deleteBerita
    final response = await http.post(ConstantFile().baseUrl + "deleteBerita" , body: {
      'idberita' : idBerita
    });

    var listData = jsonDecode(response.body);
    if(listData['status'] == 200){
      print(listData['message']);
    }else{
      print(listData['message']);
    }
  }

  @override
  void addNews(String judul, String deskripsi, File image, String idUser, String idKategori) async {
    // TODO: implement addNews
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var request = http.MultipartRequest('POST',Uri.parse(ConstantFile().baseUrl+"addBerita")); // http.MultiparRequest

    var multipart = http.MultipartFile('image', stream,length,filename: image.path);

    request.files.add(multipart);
    request.fields['judul'] = judul;
    request.fields['deskripsi'] = deskripsi;
    request.fields['iduser'] = idUser;
    request.fields['id_kategori'] = idKategori;
    var response = await request.send();
    if(response.statusCode == 200){
      print("Image Uploaded");
    }else{
      print("Image Failed Uploaded");
    }

  }

  @override
  void updateBerita(String idBerita, String myJudul, String myDeskripsi, String idKategori) async {
    // TODO: implement updateNews
    await http.post(ConstantFile().baseUrl + "updateBerita", body: {
      'judul' : myJudul,
      'deskripsi' : myDeskripsi,
      'idBerita' : idBerita,
      'idkategori' : idKategori

    });
  }

  @override
  void sendNotification(String urlImage) async{
    // TODO: implement sendNotification
    final body = jsonEncode({
      "to": "/topics/topicKabaNagari",
      "topic" : "topicKabaNagari",
      "notification" : {
        "body" : "Berita Terbaru Sanak..!!!",
        "title" : "Kaba Nagari ",
        "sound" : "default",
        "image": urlImage,
      },
      "data": {
        "body" : "Berita Terbaru Sanak..!!!",
        "title" : "Kaba Nagari",
        "sound" : "default",
        "image": urlImage,
      }
    });
    await http.post("https://fcm.googleapis.com/fcm/send", headers: {
      HttpHeaders.contentTypeHeader : "application/json",
      HttpHeaders.authorizationHeader: ConstantFile().keyServer,
    }, body: body);
  }


}