import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelKategori.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/DashboardPage.dart';
import 'package:path/path.dart' as path;
import 'package:portal_news/utils/SessionManager.dart';

class TambahBerita extends StatefulWidget {
  @override
  _TambahBeritaState createState() => _TambahBeritaState();
}

class _TambahBeritaState extends State<TambahBerita> {
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  BaseEndpoint network = NetworkProvider();
  SessionManager sessionManager = SessionManager();
  String myId;
  File _image;
  String _valKategori;
  List<Kategori> _dataKategori = List();

  void getKategori() async {
    await network.getKategori().then((value) {
      setState(() {
        _dataKategori = value;
      });
    });
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategori();
    setState(() {
      sessionManager.getPreference().then((value) {
        setState(() {
          myId = sessionManager.globalIduser;
        });
      });
    });
  }

  void myAlert(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text("Please choose media to select"),
            content: Container(
              height: MediaQuery.of(context).size.height/6.5,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                        ),
                        Text("From Galery")
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                        ),
                        Text("From Camera")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Berita'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: judulController,
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: "Judul Berita"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: deskripsiController,
                  maxLines: 18,
                  minLines: 3,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: "Deskripsi Berita"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: DropdownButton(
                  hint: Text("Pilih Kategori Berita"),
                  value: _valKategori,
                  items: _dataKategori.map((item) {
                    return DropdownMenuItem(
                      child: Text(item.namaKategori),
                      value: item.idKategori,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valKategori = value;
                    });
                  },
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: _image == null
                      ? Center()
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
                    myAlert();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.red,
                  child: Text(
                    'Select Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: RaisedButton(
                  onPressed: ()async {
                    network.addNews(judulController.text.toString(), deskripsiController.text.toString(), _image, myId, _valKategori);
                    await network.getBerita("");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashboardPage()));
                    network.sendNotification(ConstantFile().imageUrl+ path.basename( _image.path));
                    },
                  child: Text('Posting Berita'),
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
