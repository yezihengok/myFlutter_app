import 'package:flutter/material.dart';

//void main() => runApp(MyAppBar());
void main() {
  runApp(new MaterialApp(
    title: 'My app',
    home: new MyRowContnet(),
  ));

  //runApp(new MyAppContnet());
}

class MyRowContnet extends StatelessWidget {
  MyRowContnet({this.title});

  // Widget子类中的字段往往都会定义为"final"

  final Widget title;

  //线性布局Row和Column，即指沿水平或垂直方向排布子Widget。Flutter中通过Row和Column来实现线性布局，类似于Android中的LinearLayout控件。
  //Column可以在垂直方向排列其子widget。 Row可以在水平方向排列其子widget


 // children ：子Widgets数组。
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我是title? '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//(纵向对齐) 对应的 start ,center ,end 可理解为 顶部中部底部右对齐
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,//(横向对齐) 对应的 start ,center ,end 可理解为 左中右对齐
            children: <Widget>[
              Text("你好啊A"),
              Text("你好啊B"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,//类似于 warp_content ,默认是max 撑满
            mainAxisAlignment: MainAxisAlignment.center,// (横向中间对齐)这个值就没有意义了
            children: <Widget>[
              Text("你好啊A"),
              Text("你好啊B"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,//本来这个=右对齐的 ，后面rtl 让方向反过来了 ， 实际为  左对齐
            textDirection: TextDirection.rtl,//（textDirection：决定水平方向）rtl让子widget从右向左排列  因此显示的是： 你好啊B你好啊A
            children: <Widget>[
              Text("你好啊A"),
              Text("你好啊B"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("你好啊A"),
              Text("你好啊B"),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,//默认VerticalDirection=down的 start即从上往下排列=顶部对齐;而现在反过来了VerticalDirection.up，从底部向顶部排列，start的效果就是 底部对齐
            verticalDirection: VerticalDirection.up,//（verticalDirection：决定垂直方向） up从底部向顶部排列
          )
        ],
      ),
    );
  }
}
