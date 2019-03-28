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
        title: new Text('GestureDetector.dart'),
      ),
      body: _addContent(),
    );
  }
}
Widget _addContent() {
  return Center(
    child: Column(

      children: <Widget>[

        GestureDetectorTestRoute1(),

        SizedBox(
          height: 500,
          child: Flex(direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:_DragTest(),
              ),

              Expanded(
                flex: 1,
                child:_DragVertical(),
              ),


              Expanded(
                flex: 2,
                child:_ScaleTest(),
              ),

            ],
          ),

        ),


      ],

    ),
  );
}


///GestureDetector是一个用于手势识别的功能性Widget，我们通过它可以来识别各种手势

class GestureDetectorTestRoute1 extends StatefulWidget {
  @override
  _GestureDetectorTestRouteState1 createState() =>
      new _GestureDetectorTestRouteState1();
}
//点击、双击、长按
class _GestureDetectorTestRouteState1 extends State<GestureDetectorTestRoute1> {
  String _operation = "没有事件"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(//为了增大点击区域，将Container设置为200×50
          alignment: Alignment.topCenter,
          color: Colors.blue,
          width: 200.0,
          height: 50.0,
          child: Text(_operation,
            style: TextStyle(color: Colors.white),
          ),
        ),

        //tips:当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，这是因为当用户点击完之后很可能会再次点击以触发双击事件
        // ，所以GestureDetector会等一断时间来确定是否为双击事件。如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。
        onTap: () => updateText("点击事件"),//点击
        onDoubleTap: () => updateText("双击事件"), //双击
        onLongPress: () => updateText("长按事件"), //长按
      ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

///拖动、滑动

//DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置相对于屏幕(而非父widget)原点(左上角)的偏移。

//DragUpdateDetails.delta：当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。

//DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，常见的效果是根据用户抬起手指时的速度做一个减速动画。
class _DragTest extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_DragTest> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("可拖动"),radius: 30.0,backgroundColor: Colors.black54),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}


///很多场景，我们只需要沿一个方向来拖动，如一个垂直方向的列表，GestureDetector可以只识别特定方向的手势事件:
class _DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => new _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
              child: CircleAvatar(child: Text("V")),
              //垂直方向拖动事件
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              }
          ),
        )
      ],
    );
  }
}

class _ScaleTest extends StatefulWidget {
  @override
  _ScaleTestRouteState createState() => new _ScaleTestRouteState();
}

/// 缩放
class _ScaleTestRouteState extends State<_ScaleTest> {
  double _width = 100.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("./images/img1.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width=100*details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}
