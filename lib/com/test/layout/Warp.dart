import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyWarpContnet(),
  ));
}
//我们把超出屏幕显示范围会自动折行的布局称为流式布局。Flutter中通过Wrap和Flow来支持流式布局

class MyWarpContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('流式布局Wrap'),
      ),
      body: _buildWarpContnet(),
    );
  }
}

Widget _buildWarpContnet() {
  return Column(
    children: <Widget>[
      //如果子widget超出屏幕范围，则会报溢出错误:

      /*Row(
         // Row换成Wrap后溢出部分则会自动折行
          children: <Widget>[Text("xxx" * 100)],
        ),*/
      Wrap(
        spacing: 10, // 主轴(水平)方向间距
        runSpacing: 5, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        //runAlignment: , 纵轴方向的对齐方式
        children: <Widget>[
          new Chip(
              avatar: new CircleAvatar(
                backgroundColor: Colors.cyan[400],
                child: new Text('A'),
              ),
              label: new Text('小章')),
          new Chip(
              avatar: new CircleAvatar(
                backgroundColor: Colors.amber,
                child: new Text('B'),
              ),
              label: new Text('小浩')),
          new Chip(avatar: new CircleAvatar(backgroundColor: Colors.deepPurpleAccent[100],
                child: new Text('C'),
              ),
              label: new Text('小白')),
          new Chip(
              avatar: new CircleAvatar(
                backgroundColor: Colors.deepOrangeAccent,
                child: new Text('D'),
              ),
              label: new Text('小黑')),

          //这个一行显示不下了会自动换行，并居中显示（ alignment: WrapAlignment.center）
          new Chip(
              avatar: new CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                child: new Text('E'),
              ),
              label: new Text('这个一行显示不了下会换行'),backgroundColor: Colors.deepOrange[300]),
        ],
      ),
    ],
  );
}



