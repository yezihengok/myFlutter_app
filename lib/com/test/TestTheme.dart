import 'package:flutter/material.dart';



void main() {
  runApp(MTheme());
}

class MTheme extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "我是标题",

      //创建应用主题--在整个应用程序中共享包含颜色和字体样式的主题，我们可以提供ThemeData给MaterialApp的构造函数。
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[400],
        accentColor: Colors.greenAccent,
      ),
      home: new MHomePage(
        // ignore: undefined_named_parameter
        title: "我是MHomePage的标题",
      ),
    );
  }

}


class MHomePage extends StatelessWidget{
  final String title;

  MHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Container(
          color: Theme.of(context).accentColor,
          child: new Text(
            //Theme.of(context)将查找Widget树并返回树中最近的Theme。如果我们的Widget之上有一个单独的Theme定义，则返回该值。如果不是，则返回App主题。
            'Text with a background color',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),

///    局部主题
///    如果我们想在应用程序的一部分中覆盖应用程序的全局的主题，我们可以将要覆盖得部分封装在一个Theme Widget中。
///    有两种方法可以解决这个问题：创建特有的ThemeData或扩展父主题。


//        创建特有的 ThemeData
//
//    如果我们不想继承任何应用程序的颜色或字体样式，我们可以通过new ThemeData()创建一个实例并将其传递给Theme Widget。
//
//    new Theme(
//    // Create a unique theme with "new ThemeData"
//    data: new ThemeData(
//    accentColor: Colors.yellow,
//    ),
//    child: new FloatingActionButton(
//    onPressed: () {},
//    child: new Icon(Icons.add),
//    ),
//    );


//        扩展父主题
//    扩展父主题时无需覆盖所有的主题属性，我们可以通过使用copyWith方法来实现。
      floatingActionButton: new Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.yellow),
        child: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}


