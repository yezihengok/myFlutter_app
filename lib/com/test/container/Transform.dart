import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

///Transform可以在其子Widget绘制时对其应用一个矩阵变换（transformation），Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Transform'),
      ),
      body: _buildContnet(),
    );
  }
}

Widget _buildContnet() {
  //通过ConstrainedBox来确保Stack占满屏幕
  return ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式

      children: <Widget>[
        Positioned(
          top: 50,
          child: Container(
            color: Colors.brown,
            //child: Text("距离左边20"),
            child: new Transform(
              alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
              transform: new Matrix4.skewY(0.4), //沿Y轴倾斜0.4弧度
              child: new Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.deepOrange,
                child: const Text('偏移后的文本'),
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: DecoratedBox(
            //ransform.translate接收一个offset参数，可以在绘制时沿x、y轴对子widget平移指定的距离。
            decoration: BoxDecoration(color: Colors.red[100]),
            //默认原点为左上角，左移20像素，向上平移10像素
            child: Transform.translate(
              offset: Offset(-20.0, -10.0),
              child: Text("Hello world"),
            ),
          ),
        ),
        Positioned(
            top: 160,
            //Transform的变换是应用在【绘制阶段】，而并不是应用在布局(layout)阶段，所以无论对子widget应用何种变化，
            // 其占用空间的大小和在屏幕上的位置都是固定不变的 ,实际大小还是淡红色部分。
            child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red[200]),
                child: Transform.scale(
                    scale: 1.8, //放大到1.8倍
                    child: Text("Hello boys")))),

        Positioned(
            top: 210,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.cyanAccent),
              //        Transform.rotate可以对子widget进行旋转变换 --使用math.pi需先导包 import 'dart:math' as math;
              child: Transform.rotate(
                //旋转90度
                angle: math.pi / 2,
                child: Text("Hello guys"),
              ),
            )),

     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          //RotatedBox和Transform.rotate功能相似，它们都可以对子widget进行旋转变换，
          // 但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子widget的位置和大小
          child: RotatedBox(
            quarterTurns: 1, //旋转90度(1/4圈)
            child: Text("Hello world"),
          ),
        ),
        Text("SSD", style: TextStyle(color: Colors.green, fontSize: 18.0),
        )
      ],
    ),

      ],
    ),
  );
}
