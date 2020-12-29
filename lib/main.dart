import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/home.dart';
import 'package:splashscreen/splashscreen.dart';


import 'Screens/auth_type_selector.dart';

User firebaseUser = FirebaseAuth.instance.currentUser;
Widget firstWidget;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (firebaseUser != null) {
    firstWidget = Home();
  } else {
    firstWidget = AuthTypeSelector();
  }
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white,
      image: Image.asset('assets/splash.jpg'),
      photoSize: 100.0,
      loaderColor: Colors.black,
      navigateAfterSeconds: firstWidget,
    );
  }
}
