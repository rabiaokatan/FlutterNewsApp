import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/settings.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text("Haberler"),
          actions: [
            Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
            )
          ],
        ),
        body: Center(
          child: Text('Haberler'),
        ));
  }
}
