import 'dart:async';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;
  ArticleView({@required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}


class _ArticleViewState extends State<ArticleView> {
  String get newsUrl => widget.postUrl;
 
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Okatan Medya",
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.share,
            color: Colors.white, 
            ),
            onPressed: () {
              Share.share('$newsUrl Okatan medya aracılığıyla paylaşıldı.');
            },
            ),
          )
        ],
         elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
