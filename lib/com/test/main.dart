import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:myflutter_app/com/test/route/MainRoute.dart';

//main函数使用了(=>)符号, 这是Dart中单行函数或方法的简写。
//void main() => runApp(
//  //  debugPaintSizeEnabled = true;      //打开视觉调试开关
//    MainRoute());



void main(){
  runApp(new MainRoute());
  debugPaintSizeEnabled = false;      //打开视觉调试开关

  //判断如果是Android版本的话 设置Android状态栏透明沉浸式
  if(Platform.isAndroid){
    //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}


//下面这个是最简单的案例
//void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // 这个是入口
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //设置主题
      theme: ThemeData(accentColor: Colors.deepOrangeAccent, primaryColor: const Color(0xFFDE4435)),
      //设置home
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('欢迎来到App'),
        ),
        body: new Center(
          child: new Text('Hello World 你好世界'),
        ),
      ),
    );
  }
}
