import 'package:flutter/material.dart';

//void main() => runApp(MyAppBar());
void main() {
  runApp(new MaterialApp(
    title: 'My app',
    home: new MyAppContnet(),
  ));

  //runApp(new MyAppContnet());
}

class MyAppContnet extends StatelessWidget {
  MyAppContnet({this.title});

  // Widget子类中的字段往往都会定义为"final"

  final Widget title;

/*  // 资源图片
  new Image.asset('imgs/logo.jpeg'),
  //网络图片
  new Image.network(
  'https://flutter.io/images/homepage/header-illustration.png'),
  // 本地文件图片
  new Image.file(new File("/Users/gs/Downloads/1.jpeg")),
  // Uint8List图片
  new Image.memory(bytes),
  //使用ImageProvider加载图片
  new Image(image: new NetworkImage(
  "https://flutter.io/images/homepage/screenshot-2.png"),
  ---------------------
  原文：https://blog.csdn.net/poorkick/article/details/80458707 */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.access_alarm),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),
          new Image.asset('images/img1.png', width: 65, height: 65),
          new IconButton(
            icon: Image(
                image: AssetImage('images/icon_mine_user.png'),
                width: 50,
                height: 50),
            tooltip: 'Search',
            onPressed: () {
              print("d点击了");
            },
          ),
         // new Image.network('http://img4.imgtn.bdimg.com/it/u=2808542219,3839699430&fm=214&gp=0.jpg'),
          new Image(
              image: new NetworkImage(
                  "https://flutter.io/images/homepage/screenshot-2.png")),
          new Image.network(
            'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
          ),
        ],
      ),
    );
  }
}
