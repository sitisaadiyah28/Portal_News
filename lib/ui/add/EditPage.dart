import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelKategori.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/DashboardPage.dart';
import 'package:portal_news/utils/SessionManager.dart';
import 'package:http/http.dart' as http;


class EditPage extends StatefulWidget {
  String myJudul, myDeskripsi, myImage, idBerita;
  EditPage({this.myJudul, this.myDeskripsi, this.myImage, this.idBerita});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  BaseEndpoint network = NetworkProvider();
  SessionManager sessionManager = SessionManager();

  TextEditingController judulController;
  TextEditingController deskripsiController;


  String _valKategori;
  List<Kategori> _dataKategori = List();

  void getKategori() async {
    await network.getKategori().then((value) {
      setState(() {
        _dataKategori = value;
      });
    });
  }


  String myId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategori();
    setState(() {
      judulController = new TextEditingController(text: widget.myJudul);
      deskripsiController= new TextEditingController(text: widget.myDeskripsi);
      sessionManager.getPreference().then((value) {
        setState(() {
          myId = sessionManager.globalIduser;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Judul Berita', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold
                ),),
              ),
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
                child: Text('Deskripsi Berita', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),),
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
                padding: const EdgeInsets.all(8.0),
                child: Text('Kategori Berita', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),),
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: RaisedButton(
                  onPressed: ()async {
                   network.updateBerita(widget.idBerita, judulController.text, deskripsiController.text, _valKategori);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashboardPage()));

                  },
                  child: Text('Edit Berita'),
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
