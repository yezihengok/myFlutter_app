import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/animation/AnimationRoute.dart';
import 'package:myflutter_app/com/test/container/Scaffold_AppBar_TabBarView.dart';
import 'package:myflutter_app/com/test/route/BottomNavigationRoute.dart';
import 'package:myflutter_app/com/test/route/DataRoute.dart';
import 'package:myflutter_app/com/test/route/FirstScreen.dart';
import 'package:myflutter_app/com/test/route/VisibleRoute.dart';
import 'package:myflutter_app/com/test/weight/ListViewRoute.dart';
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
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0),
                  child: RaisedButton(
                      child: Text("页面跳转与传值",),

                      onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new FirstScreen()));
                      },
                    ),
                ),

                RaisedButton(
                  child: Text("底部选项卡页面切换"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new BottomNavigationRoute()));
                  },
                ),

                RaisedButton(
                  child: Text("顶部选项卡页面切换"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ScaffoldTabRoute()));
                  },
                ),

              RaisedButton(
                child: Text("控件显示&隐藏"),
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new VisibleRoute()));
                },
              ),

                RaisedButton(
                  child: Text("Sqlite&&SharedPreferences使用"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new DataRoute()));
                  },
                ),


                RaisedButton(
                  child: Text("一个简易版可上拉下拉加载的Listview"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ListViewRoute()));
                  },
                ),

                RaisedButton(
                  child: Text("动画Animation"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new AnimationRoute()));
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


