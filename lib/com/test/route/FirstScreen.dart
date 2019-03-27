import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/route/SecondScreen.dart';

void main() {
  // runApp(FirstScreen());

  runApp(new MaterialApp(
    title: 'Navigation Basics',
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Firstpage(),

      ///通过路由名打开新路由页需要：先注册路由表
      routes:{
        "new_page":(context)=>SecondScreen(),
      } ,


    );
  }
}

//在Android中，页面对应的是Activity，在iOS中是ViewController。而在Flutter中，页面只是一个widget！

//在Flutter中，我们那么我们可以使用Navigator在页面之间跳转。Navigator是一个路由管理的widget，它通过一个栈来管理一个路由widget集合
//调用Navigator.push导航到第二个页面。
//调用Navigator.pop返回第一个页面。
class Firstpage extends StatefulWidget {
  final String str;
  Firstpage({Key key, this.str}) : super(key: key);
  @override
  _MyFirstpageState createState() => new _MyFirstpageState();
}


///MaterialPageRoute 继承自 PageRoute 类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，它还定义了路由构建及切换时过渡动画的相关接口及属性
  /*MaterialPageRoute({
  WidgetBuilder builder,
  RouteSettings settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  })*/

/*builder 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
  settings 包含路由的配置信息，如路由名称、是否初始路由（首页）。
  maintainState：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false。
  fullscreenDialog表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）。*/

class _MyFirstpageState extends State<Firstpage>{

  var  title="第一个页面..";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('值:$title'),
      ),
      body:  new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            FlatButton(
              child: new Text('普通跳转'),
              onPressed: () {
                //导航到新路由
/*              Navigator.push( context,
                  new MaterialPageRoute(builder: (context) {
                    return new SecondScreen();
                  }));*/
                //=>简写 类似于lamda表达式
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen()));
              },
            ),

            new RaisedButton(
              child: new Text('点击具有返回值的跳转'),
              onPressed: () {
                //普通跳转
                // Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen(msg:"呵呵哒~")));
                _navigaten(context);

              },
            ),

            new RaisedButton(
              child: new Text('通过路由名打开新路由页'),
              onPressed: () {
                //命名路由的最大优点是直观，但其有一个明显的缺点：不能直接传递路由参数.
                Navigator.pushNamed(context, "new_page");

              },
            ),

          ],
        ),


      ),
    );
  }

  ///具有返回值的跳转 ==类似于android里的startActivityForResult
  _navigaten(BuildContext context) async {

    final result = await Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(msg: "需要呵呵哒吗？")),);
   // Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("返回的值=$result")));
    print("返回的值==========$result");

  //  setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面
    setState(() {
      title=result;
    });
  }


}
