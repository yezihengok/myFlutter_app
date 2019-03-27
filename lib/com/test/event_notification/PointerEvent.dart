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
          _PointerTestState2(),
          _PointerTestState3(),
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

//behavior属性，它决定子Widget如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值：
///deferToChild：子widget会一个接一个的进行命中测试，如果子Widget中有测试通过的，则当前Widget通过，这就意味着，如果指针事件作用于子Widget上时
// ，其父(祖先)Widget也肯定可以收到该事件。

///opaque：在命中测试时，将当前Widget当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。例如：：


class _PointerTestState1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

//    本例中，默认deferToChild 只有点击文本内容区域才会触发点击事件，因为 deferToChild 会去子widget判断是否命中测试，而该例中子widget就是 Text("Box A") 。
//    如果我们想让整个300×150的矩形区域都能点击我们可以将behavior设为HitTestBehavior.opaque
  //注意，该属性并不能用于在Widget树中拦截（忽略）事件，它只是决定命中测试时的Widget大小。
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

///translucent：当点击Widget透明区域时，可以对自身边界内及底部可视区域都进行命中测试，这意味着点击顶部widget透明区域时，顶部widget和底部widget都可以接收到事件，例如：

class _PointerTestState2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

//    上例中，当注释掉最后一行代码后，在左上角200*100范围内非文本区域点击时（顶部Widget透明区域），控制台只会打印“down0”，
//    也就是说 顶部widget没有接收到事件，而只有底部接收到了。当放开注释后，再点击时顶部和底部都会接收到事件，此时会打印：“down0” “down1”
  //如果behavior值改为HitTestBehavior.opaque，则只会打印"down1"。
    return Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 200.0)),
            child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
         // behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
        )
      ],
    );

  }
}

///忽略PointerEvent
/*
假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，这两个Widget都能阻止子树接收指针事件，
不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，这就意味着AbsorbPointer本身是可以
接收指针事件的(但其子树不行)，而IgnorePointer不可以。一个简单的例子如下：*/

class _PointerTestState3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
/*
    点击Container时，由于它在AbsorbPointer的子树上，所以不会响应指针事件，所以日志不会输出"in"，
    但AbsorbPointer本身是可以接收指针事件的，所以会输出"up"。如果将AbsorbPointer换成IgnorePointer，那么两个都不会输出*/

    return Listener(
      child: AbsorbPointer(
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200.0,
            height: 50.0,
          ),
          onPointerDown: (event)=>print("in"),
        ),
      ),
      onPointerDown: (event)=>print("up"),
    );

  }

}