import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:haber_uygulamasi/Screens/signin.dart';

import '../home.dart';
import 'register.dart';


class AuthTypeSelector extends StatefulWidget {
  @override
  _AuthTypeSelectorState createState() => _AuthTypeSelectorState();
}

class _AuthTypeSelectorState extends State<AuthTypeSelector> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Uygulamadan çıkmak istiyor musunuz?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Hayır"),
                    textColor: Colors.red,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  FlatButton(
                    child: Text("Evet"),
                    textColor: Colors.red,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Okatan Medya"),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //? Kayıt Ol Buttonu
            Container(
              child: SignInButtonBuilder(
                icon: Icons.person_add,
                backgroundColor: Theme.of(context).primaryColor,
                text: "Kayıt Ol",
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
            ),
            //? Giriş Yap Buttonu
            Container(
              child: SignInButtonBuilder(
                icon: Icons.verified_user,
                backgroundColor: Theme.of(context).primaryColor,
                text: "Giriş Yap",
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        _auth.currentUser == null ? SignInPage() : Home(),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
