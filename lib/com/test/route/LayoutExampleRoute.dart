import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/animation/AnimationRoute.dart';
import 'package:myflutter_app/com/test/container/ConstrainedBox_SizedBox.dart';
import 'package:myflutter_app/com/test/container/Scaffold_AppBar_TabBarView.dart';
import 'package:myflutter_app/com/test/eventbus/LoginRoute.dart';
import 'package:myflutter_app/com/test/file_http/HttpRoute.dart';
import 'package:myflutter_app/com/test/layout/Stack.dart';
import 'package:myflutter_app/com/test/route/BottomNavigationRoute.dart';
import 'package:myflutter_app/com/test/route/DataRoute.dart';
import 'package:myflutter_app/com/test/route/FirstScreen.dart';
import 'package:myflutter_app/com/test/route/layout_example/TestLayoutRoute.dart';
import 'package:myflutter_app/com/test/route/VisibleRoute.dart';
import 'package:myflutter_app/com/test/route/layout_example/TestLayoutRoute2.dart';
import 'package:myflutter_app/com/test/weight/Image.dart';
import 'package:myflutter_app/com/test/weight/ListViewRoute.dart';
import 'package:myflutter_app/com/test/weight/TextField_Form.dart';
class LayoutExampleRoute extends StatelessWidget {
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
        body: LayoutExampleContent(),
      ),
    );
  }
}

class LayoutExampleContent extends StatefulWidget{
  @override
  _MainRouteState createState() => new _MainRouteState();
}
class _MainRouteState extends State<LayoutExampleContent>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('测试布局例子'),
      ),
      body:
      Scrollbar(
        child: SingleChildScrollView(
          physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
          //physics:ClampingScrollPhysics(),//android滑动到边界弧形微光效果
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                RaisedButton(
                  child: Text("测试布局1"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new TestLayoutRoute()));
                  },
                ),

                RaisedButton(
                  child: Text("测试布局2"),
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new TestLayoutRoute2()));
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



