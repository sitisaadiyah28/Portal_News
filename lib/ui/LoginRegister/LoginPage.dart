import 'package:flutter/material.dart';
import 'package:portal_news/model/ModelUser.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/DashboardPage.dart';
import 'package:portal_news/ui/LoginRegister/ResgiterPage.dart';
import 'package:portal_news/ui/home/HomePage.dart';
import 'package:portal_news/utils/SessionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  GlobalKey<FormState> _key = new GlobalKey();
  SessionManager sessionManager = SessionManager();
  BaseEndpoint network = NetworkProvider();


  var globalIduser,
      globalName,
      globalEmail,
      globalPhoto,
      globalNotelp;
  var globalStatus;
  var status = false;

  var _obSecure = true;

  void onHidePassword() {
    if (_obSecure == true) {
      setState(() {
        _obSecure = false;
      });
    } else {
      setState(() {
        _obSecure = true;
      });
    }
  }

  void sendToDatabase() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (email.isEmpty || password.isEmpty) {
        print("Form Tidak Boleh Kosong");
      } else {
        List listData = await network.loginUser(
          email,
          password,
          context,
        );

        User data = listData[0];
        print("myData : ${data.namaUser}  ${data.email} ${data.notelp}, ${data.photoUser}");
        setState(() {
          status = true;
          savePreferences(status, data.idUser, data.namaUser, data.email,
              data.notelp, data.photoUser);
        });
      }
    }
  }

  void savePreferences(bool status, String idUser, String fullnameUser,
      String emailUser, String notelp, String photoUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myTelp", notelp);
    sharedPreferences.setString("myPhoto", photoUser);
    sharedPreferences.commit();
  }

  void getPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      globalStatus = sharedPreferences.getBool("myStatus");
      globalIduser = sharedPreferences.getString("myIduser");
      globalName = sharedPreferences.getString("myName");
      globalEmail = sharedPreferences.getString("myEmail");
      globalNotelp = sharedPreferences.getString("myTelp");
      globalPhoto = sharedPreferences.getString("myPhoto");

      if (globalStatus == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        print("Null");
      }
    });
    print("Global Status = $globalStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[900],
        body: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "images/kabanagari.png",
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Form Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(32),
                padding:
                    EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please Enter Your Email Address";
                        }
                      },
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      onSaved: (e) => email = e,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          //labelText: 'Email Address',
                          hintText: 'Email Address',
                          hintStyle: new TextStyle(
                              color: Colors.black, fontSize: 20.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please Enter Your Password";
                          }
                        },
                        onSaved: (e) => password = e,
                        obscureText: _obSecure,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          //labelText: 'Email Address',
                          hintText: 'Password',
                          hintStyle: new TextStyle(
                              color: Colors.black, fontSize: 20.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              onHidePassword();
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                      margin: EdgeInsets.only(top: 24, bottom: 14),
                      child: RaisedButton(
                        color: Colors.yellow[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          sendToDatabase();
                        },
                        child: Text(
                          'Login',
                          style:
                              TextStyle(color: Colors.black, letterSpacing: 3),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Sudah Punya Akun ? Daftar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
