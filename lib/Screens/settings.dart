import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/Screens/auth_type_selector.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Ayarlar"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                final User user = _auth.currentUser; 
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text("Henüz giriş yapılmamış"),
                  ));
                  return;
                }
                await _auth.signOut(); // Çıkış yapma kodu

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$uid başarıyla çıkış yaptı"),
                ));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                return AuthTypeSelector();
                 }), (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(right: 50, top: 50, left: 50),
        alignment: Alignment.topCenter,
        child: Column(
          //  Column içerisine eklenen diğer widgetların listesi
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Geliştirici",
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Developer()));
              },
            ),
            SizedBox(height: 400),
           Title(
              color: Colors.black,
              child: Text(
                "Okatan Medya v1.0",
                style: Theme.of(context).textTheme.headline1,
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class Developer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // centerTitle: true,
        title: Text("Geliştirici"),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 50, top: 50, left: 50),
        alignment: Alignment.topCenter,
        child: Column(
          //  Column içerisine eklenen diğer widgetların listesi
          children: <Widget>[
            Text(
              "Rabia Okatan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 100),
            RaisedButton(
              color: Colors.black,
              highlightColor: Colors.red,
              elevation: 10,
              child: Text(
                "Github",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: _launchURL,
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://github.com/rabiaokatan';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

