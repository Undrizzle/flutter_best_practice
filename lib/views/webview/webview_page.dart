import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({@required this.title, @required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text("Hello world"),
      ],
    );
  }
}