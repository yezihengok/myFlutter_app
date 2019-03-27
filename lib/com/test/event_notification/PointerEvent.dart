import 'package:flutter/material.dart';

/*在移动端，各个平台或UI系统的原始指针事件模型基本都是一致，即：一次完整的事件分为三个阶段：手指按下、手指移动、和手指抬起
，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。*/
void main() {
  runApp(new MaterialApp(
    title: 'Widget',
    home: new MyContnet(),
  ));
}


class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('原始指针事件'),
      ),
      //   body: ScrollControllerTestRoute(),

      body: Contet(),
    );
  }
}

class Contet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: Column(
        children: <Widget>[
          PointerTest(),
          _PointerTestState1(),
        ],
      ),
    );
  }

}


//Flutter中可以使用Listener widget来监听原始触摸事件，它也是一个功能性widget

/*Listener({
  Key key,
  this.onPointerDown, //手指按下回调
  this.onPointerMove, //手指移动回调
  this.onPointerUp,//手指抬起回调
  this.onPointerCancel,//触摸事件取消回调
  this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
  Widget child
  })*/

class PointerTest extends StatefulWidget{
  @override
  _PointerTestState createState() => new _PointerTestState();

}


///PointerEvent属性： (参数PointerDownEvent、PointerMoveEvent、PointerUpEvent都是PointerEvent的子类)

  /*position：它是鼠标相对于当对于全局坐标的偏移。
    delta：两次指针移动事件（PointerMoveEvent）的距离。
    pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
    orientation：指针移动方向，是一个角度值。*/
class _PointerTestState extends State<PointerTest>{
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,

        //tips:使用 ?. 来代替 . 可以避免因为左边对象可能为 null ， 导致的异常：
       //tips: ??    expr1 ?? expr2 如果 expr1 是 non-null， 返回 expr1 的值； 否则, 执行并返回 expr2 的值。
        child: Text(_event?.toString()??"",style: TextStyle(color: Colors.white)),
      ),
      onPointerDown: (PointerDownEvent event) => setState(()=>_event=event),
      onPointerMove: (PointerMoveEvent event) => setState(()=>_event=event),
      onPointerUp: (PointerUpEvent event) => setState(()=>_event=event),
    );
  }

}

///behavior属性，它决定子Widget如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值：
//deferToChild：子widget会一个接一个的进行命中测试，如果子Widget中有测试通过的，则当前Widget通过，这就意味着，如果指针事件作用于子Widget上时
// ，其父(祖先)Widget也肯定可以收到该事件。

//opaque：在命中测试时，将当前Widget当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。例如：：


class _PointerTestState1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 150.0)),
          child: Center(child: Text("Box A")),
        ),
        //behavior: HitTestBehavior.opaque,
        onPointerDown: (event) => print("按下 A")
    );

  }

}

