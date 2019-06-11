import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//
// 创建交错动画，需要使用多个动画对象
//一个AnimationController控制所有动画
class bar_animation_route extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<bar_animation_route>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    Fluttertoast.showToast(msg: "_playAnimation");
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              border: Border.all(
                color: Colors.pinkAccent,
              ),
            ),
            //调用我们定义的交错动画Widget
            child: BarAnimation(controller: _controller),
          ),
        ),
      ),
    );

  }

  dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    super.dispose();
  }
}

//实现一个柱状图增长的动画widget：
//
//开始时高度从0增长到320像素，同时颜色由绿色渐变为黄色；这个过程占据整个动画时间的60%。
//高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
class BarAnimation extends StatelessWidget {
  BarAnimation({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(begin: 0, end: 320).animate(
      CurvedAnimation(
          parent: controller,
          ////间隔，前60%的动画时间
          curve: Interval(0, 0.6, curve: Curves.easeIn)),
    );


    color = ColorTween(begin: Colors.green, end: Colors.yellow)
        .animate(CurvedAnimation(
            parent: controller,
            ////间隔，前60%的动画时间
            curve: Interval(0, 0.6, curve: Curves.easeIn)));

    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: 0), end: EdgeInsets.only(left: 100))
        .animate(CurvedAnimation(
            parent: controller,
            ////间隔，后40%的动画时间
            curve: Interval(0.6, 1, curve: Curves.easeIn)));
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;


  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

