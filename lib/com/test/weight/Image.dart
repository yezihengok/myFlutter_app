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

/*
  const Image({
  ...
  this.width, //图片的宽
  this.height, //图片高度
  this.color, //图片的混合色值
  this.colorBlendMode, //混合模式
  this.fit,//缩放模式
  this.alignment = Alignment.center, //对齐方式
  this.repeat = ImageRepeat.noRepeat, //指定图片的重复规则
  ...
  })*/

/*  fit：该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式如下：

  fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
  cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
  contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
  fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
  fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
  none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.fingerprint,color: Colors.green),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),

          Image(
            image: AssetImage("images/icon_mine_user.png"),
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,//color和 colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理
          ),

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

          new Image.asset('images/img1.png', width: 65, height: 65),

          new Image.network('https://avatars1.githubusercontent.com/u/17289342?s=460&v=4', width: 150, height: 100),
          new Image(
              image: new NetworkImage(
                  'https://avatars1.githubusercontent.com/u/17289342?s=460&v=4')),

        ],
      ),
    );
  }
}
