import 'package:flutter/material.dart';
void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

///DecoratedBox可以在其子widget绘制前(或后)绘制一个装饰Decoration（如背景、边框、渐变等）。
///属性：
/*  BoxDecoration({
  Color color, //颜色
  DecorationImage image,//图片
  BoxBorder border, //边框
  BorderRadiusGeometry borderRadius, //圆角
  List<BoxShadow> boxShadow, //阴影,可以指定多个
  Gradient gradient, //渐变
  BlendMode backgroundBlendMode, //背景混合模式
  BoxShape shape = BoxShape.rectangle, //形状
  })*/
class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('DecoratedBox'),
      ),
      body: _buildContnet(),
    );
  }
}

Widget _buildContnet() {
  //通过ConstrainedBox来确保Stack占满屏幕
  return ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent]), //背景渐变
                borderRadius: BorderRadius.circular(5), //5像素圆角
                boxShadow: [
                  //阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    ),

  );
}
