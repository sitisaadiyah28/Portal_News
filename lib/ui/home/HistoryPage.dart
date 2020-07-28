import 'package:flutter/material.dart';
import 'package:portal_news/network/NetworkProvider.dart';
import 'package:portal_news/ui/list/ListBerita.dart';
import 'package:portal_news/ui/list/ListBeritaUser.dart';
import 'package:portal_news/utils/SessionManager.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  BaseEndpoint network = NetworkProvider();
  String myId;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    // TODO: implement initState

    sessionManager.getPreference().then((value) {
      setState(() {
        myId = sessionManager.globalIduser;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          myId == null? Center() : Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: network.getBerita(myId),
                builder: (context, result) {
                  if (result.hasError) print(result.error);
                  return result.hasData
                      ? ListBeritaUser(list: result.data)
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
