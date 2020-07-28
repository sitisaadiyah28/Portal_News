import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils{

  void savePreferences(bool status, String idUser, String fullnameUser, String emailUser, String noTelp, String photoUser);
  Future getPreference();
}

class SessionManager extends RuleUtils{

  String globalIduser, globalName, globalEmail, globalNotelp, globalPhoto;
  bool globalStatus;

  @override
  Future getPreference() async{
    // TODO: implement getPreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    globalStatus = sharedPreferences.getBool("myStatus");
    globalIduser = sharedPreferences.getString("myIduser");
    globalName = sharedPreferences.getString("myName");
    globalEmail = sharedPreferences.getString("myEmail");
    globalNotelp = sharedPreferences.getString("myTelp");

  }

  @override
  void savePreferences(bool status, String idUser, String fullnameUser,
      String emailUser, String notelp, String photoUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myTelp", notelp);
    sharedPreferences.commit();
  }

}
