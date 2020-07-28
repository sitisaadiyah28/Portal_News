import 'package:flutter/material.dart';
import 'package:portal_news/network/NetworkProvider.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String fullname, email, telp, password;
  GlobalKey<FormState> _key = new GlobalKey();

  BaseEndpoint network = NetworkProvider();
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

  void sendToDatabase() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (fullname.isEmpty ||
          email.isEmpty ||
          telp.isEmpty ||
          password.isEmpty) {
        print("Form Tidak Boleh Kosong");
      } else {
        network.registerUser(
            fullname, email, telp, password, context);
      }
    }
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
                  "Form Register",
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
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please Enter Your Full Name";
                        }
                      },
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      onSaved: (e) => fullname = e,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          //labelText: 'Email Address',
                          hintText: 'Fullname',
                          hintStyle: new TextStyle(
                              color: Colors.black, fontSize: 20.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Please Enter Your Phone Number";
                          }
                        },
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        onSaved: (e) => telp = e,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            //labelText: 'Email Address',
                            hintText: 'Phone Number',
                            hintStyle: new TextStyle(
                                color: Colors.black, fontSize: 20.0)),
                      ),
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
                              _obSecure ? Icons.visibility : Icons.visibility_off,
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
                          'Register',
                          style: TextStyle(color: Colors.black, letterSpacing: 3),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
