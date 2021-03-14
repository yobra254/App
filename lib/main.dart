import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  String id;
  String url;
  String title;
  String text;
  String publisher;
  String author;
  String image;
  String date;

  News(this.id, this.url, this.title, this.text, this.publisher, this.author,
      this.image, this.date);

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    text = json['text'];
    publisher = json['publisher'];
    author = json['author'];
    image = json['image'];
    date = json['date'];
  }
}

class NewsApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

void main() {
  runApp(NewsApp());
}

class _HomePageState extends State<HomePage> {
  static List<News> _news = List<News>();
  static List<News> _newsInApp = List<News>();
  Future<List<News>> comingNews() async {
    var url = 'http://www.mocky.io/v2/5ecfddf13200006600e3d6d0';
    var response = await http.get(Uri.parse(url));
    var news = List<News>();

    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);
      for (var noteJson in notesJson) {
        news.add(News.fromJson(noteJson));
      }
    }
    return news;
  }

  @override
  void initState() {
    comingNews().then((value) {
      setState(() {
        _news.addAll(value);
        _newsInApp = _news;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(97),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                        width: 0.5,
                        color: Colors.white,
                      ))),
                  child: AppBar(
                    title: Text(
                      'Brian News',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                )
              ]),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return _listItem(index);
          },
          itemCount: _newsInApp.length,
        ));
  }

  _listItem(index) {
    return Container(
      child: Column(children: <Widget>[]),
    );
  }
}
