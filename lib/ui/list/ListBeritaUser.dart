import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/model/ModelBerita.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/home/DetailBeritaUser.dart';


class ListBeritaUser extends StatefulWidget {
  List list;
  ListBeritaUser({this.list});

  @override
  _ListBeritaUserState createState() => _ListBeritaUserState();
}

class _ListBeritaUserState extends State<ListBeritaUser> {
  BaseEndpoint network = NetworkProvider();
  var dateFormat;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBeritaUser(
                              idBerita : a.idBerita,
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
                      height: 30,
                      width: 200,
                      child: Text(
                        a.deskripsi,
                        style: TextStyle(fontStyle: FontStyle.italic),
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.delete
                          ),
                          Text('Hapus')
                        ],
                      ),
                      onPressed: () async{
                        network.deleteBerita(
                            a.idBerita);
                        setState(() {
                          widget.list.removeAt(index);
                        });
                        await network.getBerita("");
                      },
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