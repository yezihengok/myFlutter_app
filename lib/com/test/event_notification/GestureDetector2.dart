import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}
class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GestureDetector2.dart'),
      ),
      body: _addContent(),
    );
  }
}

///GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势
//GestureDetector直接可以接收一个子Widget。GestureRecognizer是一个抽象类，一种手势的识别器对应一个GestureRecognizer的子类，Flutter实现了丰富的手势识别器，可以直接使用。
Widget _addContent() {
  return Center(
    child: Column(

      children: <Widget>[

        GestureRecognizerTest1(),
        SizedBox(
          height: 600,
          child: Flex(direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:BothDirectionTest(),
              ),
              Expanded(
                flex: 1,
                child:GestureConflictTest(),
              ),

              Expanded(
                flex: 1,
                child:GestureConflictTest2(),
              ),



            ],
          ),

        ),


      ],

    ),
  );
}


///假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，但是TextSpan并不是一个Widget，这时我们不能用GestureDetector，
///但TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer

class GestureRecognizerTest1 extends StatefulWidget {
  @override
  _GestureRecognizerTestRouteState createState() => new _GestureRecognizerTestRouteState();
}
class _GestureRecognizerTestRouteState extends State<GestureRecognizerTest1> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关



  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
          TextSpan(
              children: [
                TextSpan(text: "这是个文本"),
                TextSpan(
                  text: "点击变色",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red
                  ),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                ),
                TextSpan(text: "这是个文本"),
              ]
          )
      ),
    );
  }
}

//手势竞争与冲突
/*
我们同时监听水平和垂直方向的拖动事件，那么我们斜着拖动时哪个方向会生效？实际上取决于第一次移动时两个轴上的位移分量，哪个轴的大，哪个轴在本次滑动事件竞争中就胜出。
例如，假设有一个ListView，它的第一个子Widget也是ListView，如果现在滑动这个子ListView，父ListView会动吗？答案是否定的，这时只有子Widget会动，
因为这时子Widget会胜出而获得滑动事件的处理权。*/

///竞争：
///以拖动手势为例，同时识别水平和垂直方向的拖动手势，当用户按下手指时就会触发竞争（水平方向和垂直方向），一旦某个方向“获胜”，则直到当次拖动手势结束都会沿着该方向移动：
class BothDirectionTest extends StatefulWidget {
  @override
  BothDirectionTestRouteState createState() =>
      new BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTest> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          //竞争发生在手指按下后首次移动（move）时，此例中具体的“获胜”条件是：首次移动时的位移在水平和垂直方向上的分量大的一个获胜
          child: GestureDetector(
            child: CircleAvatar(child: Text("竞争"),radius: 30.0,backgroundColor: Colors.black54),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            //水平方向拖动事件
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}

///手势冲突
//由于手势竞争最终只有一个胜出者，所以，当有多个手势识别器时，可能会产生冲突。假设有一个widget，它可以左右拖动，现在也想检测在它上面手指按下和抬起的事件如下：

class GestureConflictTest extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() =>
      new _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState extends State<GestureConflictTest> {
  double _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("手势冲突"),radius: 30.0,backgroundColor: Colors.black54),//要拖动和点击的widget
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details){
              print("onHorizontalDragEnd");
            },
            onTapDown: (details){
              print("onTapDown");
            },
            onTapUp: (details){
              print("onTapUp");
            },
          ),
        )



      ],
    );
  }
}
///按住圆形 拖动然后抬起手指，控制台日志如下:
//I/flutter (17539): onTapDown
//I/flutter (17539): onHorizontalDragEnd

//发现没有打印"onTapUp"，这是因为在拖动时，刚开始按下手指时在没有移动时，拖动手势还没有完整的语义，此时TapDown手势胜出，此时打印"onTapDown"，而拖动时，
//拖动手势会胜出，当手指抬起时，onHorizontalDragEnd 和 onTapUp发生了冲突，但是因为是在拖动的语义中，所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。





//如果我们的代码逻辑中，对于手指按下和抬起是强依赖的，比如在一个轮播图组件中，我们希望手指按下时，暂停轮播，而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动
//手势（支持手动滑动切换），甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。这时应该怎么做？其实很简单，
//通过Listener监听原始指针事件就行：

///按住圆形 拖动然后抬起手指，控制台日志如下:
//I/flutter (14922): onTapDown
//I/flutter (14922): onPointerUp
//I/flutter (14922): onHorizontalDragEnd
class GestureConflictTest2 extends StatefulWidget {
  @override
  _GestureConflictTestRouteState2 createState() =>
      new _GestureConflictTestRouteState2();
}


class _GestureConflictTestRouteState2 extends State<GestureConflictTest2> {
  double _left2 = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top:80.0,
          left: _left2,
          child: Listener(
            onPointerDown: (details) {
              print("onTapDown");
            },
            onPointerUp: (details) {
              //会触发
              print("onPointerUp");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("手势冲突-解决"),radius: 40.0,backgroundColor: Colors.black26),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left2 += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        )
      ],
    );
  }
}