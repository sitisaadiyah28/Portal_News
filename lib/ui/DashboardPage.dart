import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:portal_news/constant/ConsantFile.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/LoginRegister/LoginPage.dart';
import 'package:portal_news/ui/home/HistoryPage.dart';
import 'package:portal_news/ui/home/HomePage.dart';
import 'package:portal_news/ui/profil/ProfilPage.dart';
import 'package:portal_news/utils/SessionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String myId, myEmail, myFullname, myTelp, myFoto;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BaseEndpoint network = NetworkProvider();
  int _selectedIndex = 0;

  onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var listPage = [
    HomePage(),
    HistoryPage(),
  ];

  final _bottomNavItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      title: Text('History'),
    ),
  ];

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  SessionManager sessionManager = SessionManager();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic("InternshipTopic");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        final data = message['data'];
        print("Onteset : ${notification['title']}");
        print("Onteset : ${data['image']}");
      },

      //kalau aplikasi mati maka notifikasinya akan muncul
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['notication'];
        print("Onteset : ${notification['title']}");
      },

      //Jalan di background aplikasi
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final notification = message['notication'];
        print(notification['title']);
      },
    );

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
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Kaba Nagari',
              style: TextStyle(fontSize: 16),
            ),
            accountEmail: Text('kabanagari@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 100,
              child: Image(
                image: AssetImage("images/kabanagari.png"),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red[900]),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profil Saya'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Tentang Aplikasi'),
            /*onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TentangPage()));
                },*/
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Keluar'),
            onTap: () {
              signOut();
            },
          ),
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Container(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "images/kabanagari.png",
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'KABA ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              Text(
                "NAGARI",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 2, fontSize: 18),
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: listPage[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: _bottomNavItem,
        currentIndex: _selectedIndex,
        onTap: onSelected,
      ),
    );
  }
}
