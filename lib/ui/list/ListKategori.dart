import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelKategori.dart';
import 'package:portal_news/ui/list/ListDetailKategori.dart';

class ListKategoriPage extends StatelessWidget {
  List list;
  ListKategoriPage({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Kategori data = list[index];
          return Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width / 2.5,
            child: GestureDetector(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ListDetailKategori(
                    idKategori : data.idKategori,
                    namaKategori : data.namaKategori
                )));
              },
              child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          radius: 60,
                          child: Container(
                              height: 100,
                              width: 100,
                              child: Image(
                                image: NetworkImage(
                                    ConstantFile().imageUrl + data.images),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 35,
                        width: 95,
                        child: Card(
                            color: Colors.red[900],
                            elevation: 5,
                            child: Text(
                              data.namaKategori,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
