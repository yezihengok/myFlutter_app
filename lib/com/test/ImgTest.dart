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

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),

      // Row 是水平方向的线性布局（linear layout）
      child: new Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),
          // Expanded expands its child to fill the available space.（填充空间 ，类似于权重weight）
          new Expanded(
            child: title,

          ),
          new IconButton(
            icon: Image(image: AssetImage('images/icon_mine_user.png'),width:40,height:40),
            tooltip: 'Search',
            onPressed: null,
          ),


        ],
      ),
    );
  }
}