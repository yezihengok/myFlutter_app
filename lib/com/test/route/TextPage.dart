import 'package:flutter/material.dart';
class TextPage extends StatelessWidget {

  final msg;
  const TextPage({Key key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("第二个页面"),
//      ),
      body: new Center(
          child: new Text('内容:$msg'),
        ),
    );
  }
}