import 'package:haber_uygulamasi/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {

  List<Article> news  = [];

  Future<void> getNews() async{

    String url ="https://newsapi.org/v2/everything?domains=aa.com.tr&apiKey=0e7026f334154163a5b9f033d6d89c07";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
