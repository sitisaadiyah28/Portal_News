import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelBerita.dart';
import 'package:portal_news/model/ModelBeritaKategori.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/home/DetailBerita.dart';


class ListDetailKategori extends StatefulWidget {
  String idKategori, namaKategori;
  ListDetailKategori({this.idKategori, this.namaKategori});
  @override
  _ListDetailKategoriState createState() => _ListDetailKategoriState();
}

class _ListDetailKategoriState extends State<ListDetailKategori> {
  BaseEndpoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaKategori),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: FutureBuilder(
                future: network.getBeritaByIdKategori(widget.idKategori),
                builder: (context, result) {
                  if (result.hasError) print(result.error);
                  return result.hasData
                      ? ItemDetailBeritaKategori(list: result.data)
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

class ItemDetailBeritaKategori extends StatelessWidget {
  List list;
  ItemDetailBeritaKategori({this.list});

  @override
  Widget build(BuildContext context) {
    var dateFormat;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (context, index) {
        Beritakategori b = list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(b.createdAt);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Container(
                    height: 130,
                    width: 130,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          ConstantFile().imageUrl + b.imagesBerita,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBerita(
                                judul : b.judulBerita,
                                deskripsi : b.deskripsi,
                                image : b.imagesBerita,
                                namaUser : b.namaUser,
                                namaKategori : b.namaKategori,
                                date : dateFormat,
                                fotoUser : b.photoUser

                            )));
                          },
                          child: Text(
                            b.judulBerita,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(b.namaUser == null ? "0" : b.namaUser,
                            style: TextStyle(fontSize: 12),),
                          Padding(
                            padding:  EdgeInsets.only(left:5.0),
                            child: Text("|"),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 5.0),
                            child: Text(
                              dateFormat,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text("|"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              b.namaKategori,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        child: Text(
                          b.deskripsi,
                          style: TextStyle(fontStyle: FontStyle.italic),
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

