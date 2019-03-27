import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

///ScrollController
/*ScrollController({
  double initialScrollOffset = 0.0, //初始滚动位置
  this.keepScrollOffset = true,//是否保存滚动位置
  ...
  })*/
// 滚动监听 controller.addListener(()=>print(controller.offset))

//controller.offset：可滚动Widget当前滚动的位置。

//controller.jumpTo(double offset)、animateTo(double offset,...)：这两个方法用于跳转到指定的位置，后者在跳转时会执行一个动画，而前者不会。
class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('滚动监听及控制'),
      ),
   //   body: ScrollControllerTestRoute(),

      body: ScrollNotificationTest(),
    );
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  ScrollControllerTestRouteState createState() {
    return new ScrollControllerTestRouteState();
  }
}


///demo:当前位置是否超过1000像素，如果超过则在屏幕右下角显示一个“返回顶部”的按钮
class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("滚动控制")),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(title: Text("$index"),);
            }
        ),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _controller.animateTo(.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease//动画曲线是Curves.ease
            );
          }
      ),
    );
  }
}


///ScrollPosition 一个ScrollController可以同时被多个Scrollable Widget使用，假设一个ScrollController同时被两个Scrollable Widget使用
///，那么我们可以通过如下方式分别读取他们的滚动位置：
//double offset =controller.positions.elementAt(0).pixels
//controller.positions.elementAt(1).pixels


//滚动监听
/*
Flutter Widget树中子Widget可以通过发送通知（Notification）与父(包括祖先)Widget通信。父Widget可以通过NotificationListener Widget来监听自己关注的通知，
这种通信方式类似于Web开发中浏览器的事件冒泡，Scrollable Widget在滚动时会发送ScrollNotification类型的通知，ScrollBar正是通过监听滚动通知来实现的。
通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同：

通过NotificationListener可以在从Scrollable Widget到Widget树根之间任意位置都能监听。而ScrollController只能和具体的Scrollable Widget关联后才可以。
收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。*/
///NotificationListener

/*NotificationListener是一个Widget，模板参数T是想监听的通知类型，如果省略，则所有类型通知都会被监听，如果指定特定类型，则只有该类型的通知会被监听。
NotificationListener需要一个onNotification回调函数，用于实现监听处理逻辑，该回调可以返回一个布尔值，代表是否阻止该事件继续向上冒泡，如果为true时
，则冒泡终止，事件停止向上传播，如果不返回或者返回值为false 时，则冒泡继续。*/

///监听ListView的滚动通知，然后显示当前滚动进度百分比：
class ScrollNotificationTest extends StatefulWidget {
  @override
  _ScrollNotificationTestRouteState createState() =>
      new _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTest> {
  String _progress = "0%"; //保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scrollbar( //进度条
      // 监听滚动通知
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          //重新构建
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          print("列表中未滑入ViewPort部分的长度: ${notification.metrics.extentAfter}");//即ViewPort 还剩余多少没有滑完

          print("是否滑动到底部== ${notification.metrics.extentAfter==0}");//根据这个是否=0 可判断是否滑动到底部

          print("滑出ViewPort顶部的长度: ${notification.metrics.extentBefore}");//即ViewPort 已滑的距离 相当于顶部滑出屏幕上方的列表长度。

          print("是否滑动到顶部== ${notification.metrics.extentBefore==0}");//根据这个是否=0 可判断是否滑动到顶部

          //当然是否滑动到顶部底部 也可直接根据 progress 判断就好了

        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }
            ),
            CircleAvatar(  //显示进度百分比
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}

/*在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：

pixels：当前滚动位置。
maxScrollExtent：最大可滚动长度。
extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
atEdge：是否滑到了Scrollable Widget的边界（此示例中相当于列表顶或底部）。*/
