import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/route/BottomNavigationRoute.dart';
import 'package:myflutter_app/com/test/route/FirstScreen.dart';
class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //设置主题
      theme: ThemeData(accentColor: Colors.deepOrangeAccent, primaryColor: const Color(0xFFDE4435)),
      //设置home
      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('欢迎来到App'),
//        ),
        body: MainRouteContent(),
      ),
    );
  }
}

class MainRouteContent extends StatefulWidget{
  @override
  _MainRouteState createState() => new _MainRouteState();
}
class _MainRouteState extends State<MainRouteContent>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SingleChildScrollView'),
      ),
      body:
      Scrollbar(
        child: SingleChildScrollView(
//physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
          physics:ClampingScrollPhysics(),//android滑动到边界弧形微光效果
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  child: Text("页面跳转与传值"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new FirstScreen()));
                  },
                ),

                RaisedButton(
                  child: Text("底部选项卡页面切换"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new BottomNavigationRoute()));
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

}


