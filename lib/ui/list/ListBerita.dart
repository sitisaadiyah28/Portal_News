import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelBerita.dart';
import 'package:portal_news/ui/home/DetailBerita.dart';

class ListBerita extends StatefulWidget {
  List list;
  ListBerita({this.list});

  @override
  _ListBeritaState createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
  var dateFormat;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        Berita a = widget.list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(a.createdAt);
        return Card(
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
                        ConstantFile().imageUrl + a.imagesBerita,
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
                            judul : a.judulBerita,
                            deskripsi : a.deskripsi,
                            image : a.imagesBerita,
                            namaUser : a.namaUser,
                            namaKategori : a.namaKategori,
                            date : dateFormat,
                            fotoUser : a.photoUser

                          )));
                        },
                        child: Text(
                          a.judulBerita,
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
                        Text(a.namaUser == null ? "0" : a.namaUser,
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
                            a.namaKategori,
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
                        a.deskripsi,
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
        );
      },
    );
  }
}
