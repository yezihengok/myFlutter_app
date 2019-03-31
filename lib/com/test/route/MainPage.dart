import 'package:flutter/material.dart';
class MainPage extends StatelessWidget {

  final msg;
  const MainPage({Key key, this.msg}) : super(key: key);
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