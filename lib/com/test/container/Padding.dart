import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyWarpContnet(),
  ));
}
//Padding可以给其子节点添加补白（填充）

class MyWarpContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Padding_'),
      ),
      body: _buildWarpContnet(),
    );
  }
}
/// EdgeInsets属性:
/*fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的补白。
  all(double value) : 所有方向均使用相同数值的补白。
  only({left, top, right ,bottom })：可以设置具体某个方向的补白(可以同时指定多个方向)。
  symmetric({ vertical, horizontal })：用于设置对称方向的补白，vertical指top和bottom，horizontal指left和right。*/

Widget _buildWarpContnet() {
  return Padding(

    padding: EdgeInsets.all(15.0),    //上下左右各添加15像素补白
    child: Column(
      //显式指定对齐方式为左对齐，排除对齐干扰
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          //左边添加8像素补白
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("哒哒哒"),
        ),
        Padding(
          //上下各添加8像素补白
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("咚咚咚"),
        ),
        Padding(
          // 分别指定四个方向的补白
          padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
          child: Text("滴滴滴"),
        )
      ],
    ),
  );
}
