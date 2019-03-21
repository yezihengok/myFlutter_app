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
  final Widget title;

 // 特殊情况:如果Row里面嵌套Row，或者Column里面再嵌套Column，那么只有对最外面的Row或Column会占用尽可能大的空间，
  // 里面Row或Column所占用的空间为实际大小，
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我是title? '),
      ),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
            children: <Widget>[

          Container(
              color: Colors.yellowAccent[400],
              child: Column(
                mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度
                children: <Widget>[
                  Text("hello world "),
                  Text("ok_go_go "),
                ],
              ),
              ),

          ///如果要让里面的Colum占满外部Colum，可以使用Expanded widget：
         /* Expanded(
            child: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                children: <Widget>[
                  Text("hello world "),
                  Text("I am Jack "),
                ],
              ),
            ),
          )*/


            ],
          ),
        ),
      ),

      //如果要让里面的Colum占满外部Colum，可以使用Expanded widget：


    );
  }
}
