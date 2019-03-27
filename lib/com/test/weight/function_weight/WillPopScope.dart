import 'package:flutter/material.dart';

//功能型Widget指的是不会影响UI布局及外观的Widget，它们通常具有一定的功能，如事件监听、数据存储等，我们之前介绍过的FocusScope（焦点控制）
//、PageStorage（数据存储）、NotificationListener（事件监听）都属于功能型Widget。
void main() {
  runApp(new MaterialApp(
    title: '功能型Widget',
    home: new MyContnet(),
  ));
}

//为了避免用户误触返回按钮而导致APP退出，在很多APP中都拦截了用户点击返回键的按钮，当用户在某一个时间段内点击两次时，才会认为用户是要退出（而非误触）。
//Flutter中可以通过WillPopScope来实现返回按钮拦截， WillPopScope的默认构造函数：

  /*const WillPopScope({
  ...
  @required WillPopCallback onWillPop,
  @required Widget child
  })*/


class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('导航返回拦截WillPopScope'),
      ),
      //   body: ScrollControllerTestRoute(),

      body: WillPopScopeRoute (),
    );
  }
}

class WillPopScopeRoute extends StatefulWidget {
  @override
  WillPopScopeRouteState createState() {
    return new WillPopScopeRouteState();
  }
}

class WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(

      //onWillPop是一个回调函数，当用户点击返回按钮时调用（包括导航返回按钮及Android物理返回按钮）false,当前路由不出栈(页面关闭)、true 退出
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        )
    );
  }
}