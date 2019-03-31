import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/route/MainPage.dart';
import 'package:myflutter_app/com/utils/ToastUtils.dart';
class BottomNavigationRoute extends StatefulWidget{
  _BottomNavigationRouteState createState() => new _BottomNavigationRouteState();
}

//Tab页的切换搭配了动画，因此到State类上附加一个 StateMixin: SingleTickerProviderStateMixin
class _BottomNavigationRouteState  extends State<BottomNavigationRoute>{
  //默认索引
  int positionIndex = 0;
  //底部导航栏
  var mainTitles = ['首页', '我的', '设置'];
  List<BottomNavigationBarItem> navigationViews;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        //title
        title: new Text(
          mainTitles[positionIndex],
          style: new TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),
        ),

        //这个相当于actionBar上的menu
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.broken_image),
              onPressed: () {
                /*         navigatorKey.currentState.push(new MaterialPageRoute(builder: (context) {
                return null;
              }));*/
              }),
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                ToastUtils.showToast("什么也没有");
              }),
        ],
      ),

      //切换的页面
      body: IndexedStack(
        children: <Widget>[new MainPage(msg:"第1页"), new MainPage(msg:"第2页"),new MainPage(msg:"第3页")],
        index: positionIndex,
      ),

      //相当于底部导航栏
      bottomNavigationBar: new BottomNavigationBar(
        items: navigationViews.map((BottomNavigationBarItem navigationView) => navigationView).toList(),
        currentIndex: positionIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            positionIndex = index;
          });
        },
      ),

    );

  }


  //这个方法setState()会调用，初次绘制也会调用
  @override
  void initState() {
    super.initState();
    navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(mainTitles[0]),
        backgroundColor: Colors.blue,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(mainTitles[1]),
        backgroundColor: Colors.blue,
      ),

      new BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        title: new Text(mainTitles[2]),
        backgroundColor: Colors.blue,
      ),
    ];
  }

}