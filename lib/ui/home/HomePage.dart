import 'package:flutter/material.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/list/ListBerita.dart';
import 'package:portal_news/ui/list/ListKategori.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseEndpoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10),
            child: Container(
              height: 40,
              child: Text(
                'Kategori Berita',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            height: 200,
            child: FutureBuilder(
                future: network.getKategori(),
                builder: (context, result) {
                  if (result.hasError) print(result.error);
                  return result.hasData
                      ? ListKategoriPage(list: result.data)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Container(
                  height: 40,
                  child: Text(
                    'Berita Terbaru',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: FutureBuilder(
                future: network.getBerita(""),
                builder: (context, result) {
                  if (result.hasError) print(result.error);
                  return result.hasData
                      ? ListBerita(list: result.data)
                      : Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
