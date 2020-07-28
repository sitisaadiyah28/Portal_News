import 'package:flutter/material.dart';
import 'package:portal_news/constant/ConsantFile.dart';

class DetailBerita extends StatefulWidget {
  String judul, deskripsi, image, namaUser, namaKategori, date, fotoUser;
  DetailBerita(
      {this.judul,
      this.deskripsi,
      this.image,
      this.namaUser,
      this.namaKategori,
      this.fotoUser,
      this.date});
  @override
  _DetailBeritaState createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.judul),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text(
              widget.judul,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        ConstantFile().imageUrl + widget.fotoUser,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.namaUser),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.date)
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Image(
                        width: 40,
                        height: 40,
                        image: AssetImage(
                          "images/facebook.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Image(
                          width: 40,
                          height: 40,
                          image: AssetImage(
                            "images/instagram.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Image(
                          width: 40,
                          height: 40,
                          image: AssetImage(
                            "images/google.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(ConstantFile().imageUrl + widget.image),
                      fit: BoxFit.cover))),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 50),
            child: Text(
              widget.deskripsi,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.justify,
            ),
          ),

        ],
      ),
    );
  }
}
