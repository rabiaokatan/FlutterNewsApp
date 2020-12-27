import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haber_uygulamasi/home.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Giriş Yap"),
      ),
      body: _SignInBody(),
    );
  }
}

class _SignInBody extends StatefulWidget {
  @override
  __SignInBodyState createState() => __SignInBodyState();
}

class __SignInBodyState extends State<_SignInBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.vertical,
        children: [
          //? Email / Şifre ile giriş
          _EmailPasswordForm(),
          //? Google ile giriş
          _SignInProvider(
            infoText: "Google ile giriş yap",
            buttonType: Buttons.Google,
            signInMethod: () async => _signInWithGoogle(),
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("${user.displayName}, Google ile giriş yaptı."),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.message}"),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Google ile giriş yaparken bir hata oluştu!"),
        ),
      );
    }
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  __EmailPasswordFormState createState() => __EmailPasswordFormState();
}

class __EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? Bilgi
              Container(
                child: Text(
                  "Email ve Şifre ile Giriş Yap",
                  style: Theme.of(context).textTheme.headline2,
                ),
                alignment: Alignment.center,
              ),
              //? E-Mail
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-Mail"),
                validator: (String mail) {
                  if (mail.isEmpty) return "Lütfen bir mail yazın";
                  return null;
                },
              ),
              //? Şifre
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Şifre"),
                validator: (String password) {
                  if (password.isEmpty) return "Lütfen bir şifre yazın";
                  return null;
                },
                obscureText: true, //! Şifrenin görünmesini engeller.
              ),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                child: SignInButton(Buttons.Email, text: "Email ile giriş yap",
                    onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [Email] ve [Password] ile kullanıcı girişi yapar.
  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ))
          .user;
      // final user = userCredential.user;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${user.email} ile giriş yapıldı."),
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${e.message}"),
      ));
    } catch (e) {
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email & Şifre ile giriş yaparken bir sorun oluştu"),
      ));
    }
  }
}

class _SignInProvider extends StatefulWidget {
  final String infoText;
  final Buttons buttonType;
  final Function signInMethod;

  const _SignInProvider({
    Key key,
    @required this.infoText,
    @required this.buttonType,
    @required this.signInMethod,
  }) : super(key: key);

  @override
  __SignInProviderState createState() => __SignInProviderState();
}

class __SignInProviderState extends State<_SignInProvider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.infoText,
                style: Theme.of(context).textTheme.headline2,
                //TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: SignInButton(
                widget.buttonType,
                text: widget.infoText,
                onPressed: () async => widget.signInMethod(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
