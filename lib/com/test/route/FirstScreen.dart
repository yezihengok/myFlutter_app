import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/route/SecondScreen.dart';

void main() {
  // runApp(FirstScreen());

  runApp(new MaterialApp(
    title: 'Navigation Basics',
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Firstpage(),
    );
  }
}

//在Android中，页面对应的是Activity，在iOS中是ViewController。而在Flutter中，页面只是一个widget！
//调用Navigator.push导航到第二个页面。
//调用Navigator.pop返回第一个页面。
//
//在Flutter中，我们那么我们可以使用Navigator在页面之间跳转。
class Firstpage extends StatefulWidget {
  final String str;
  Firstpage({Key key, this.str}) : super(key: key);
  @override
  _MyFirstpageState createState() => new _MyFirstpageState();
}

class _MyFirstpageState extends State<Firstpage>{


  var  title="第一个页面..";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$title'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('点击跳转`'),
          onPressed: () {
            //普通跳转
           // Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen(msg:"呵呵哒~")));
           _navigaten(context);

         //  test();
          },
        ),
      ),
    );
  }


  _navigaten(BuildContext context) async {

    final result = await Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(msg: "需要呵呵哒吗？")),);
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("返回的值=$result")));
    print("返回的值==========$result");
  //  setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面
    setState(() {
      title=result;
    });
  }
}
