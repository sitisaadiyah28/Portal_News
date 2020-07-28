import 'package:flutter/material.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/ui/LoginRegister/LoginPage.dart';
import 'package:portal_news/ui/add/TambahBerita.dart';
import 'package:portal_news/ui/home/HistoryPage.dart';
import 'package:portal_news/utils/SessionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String myId, myEmail, myFullname, myTelp, myFoto;
  SessionManager sessionManager = SessionManager();

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.getPreference().then((value) {
      setState(() {
        myId = sessionManager.globalIduser;
        myEmail = sessionManager.globalEmail;
        myFullname = sessionManager.globalName;
        myTelp = sessionManager.globalNotelp;
        myFoto = sessionManager.globalPhoto;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.red[900],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/marawa.png'),
                  fit: BoxFit.cover,
                )),
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 32),
                    width: 140,
                    height: 140,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("images/user.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
            child: Container(
              height: 70,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        myFullname == null ? "" : myFullname,
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
            child: Container(
              height: 70,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        myEmail == null ? "" : myEmail,
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
            child: Container(
              height: 70,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        myTelp == null ? "" : myTelp,
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text('Posting'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TambahBerita()));
                  },
                  color: Colors.green,
                ),
                RaisedButton(
                  child: Text('History'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  },
                  color: Colors.blue,
                ),
                RaisedButton(
                  child: Text('Keluar'),
                  onPressed: () {
                    signOut();
                  },
                  color: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
