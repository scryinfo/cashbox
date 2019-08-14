import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black26,
        leading: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.maybePop(context);
            }),
        centerTitle: true,
        title: new Text("公告"),
      ),
      body: Container(
        height: 900,
        child: WebView(
          initialUrl: "https://cashbox.scry.info/public",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
