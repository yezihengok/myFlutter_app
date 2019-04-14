import 'package:flutter/material.dart';

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState2 createState() => new _ScaleAnimationRouteState2();
}

/// addStatusListener 动画状态监听  枚举值	含义
  /*dismissed	动画在起始点停止
  forward	动画正在正向执行
  reverse	动画正在反向执行
  completed	动画在终点停止*/
class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);

    //使用弹性曲线( Curve类似于android里动画里的插值器)
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
    //animation.addStatusListener((status) {
    ..addStatusListener((status){

      ///将上面图片放大的示例改为先放大再缩小再放大…
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return SacleTransition(
      child: Image.asset("images/img2.png"),
      animation: animation,
    );

  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}


class SacleTransition extends StatelessWidget {
  SacleTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value,
                width: animation.value,
                child: child
            );
          },
          child: child
      ),
    );
  }
}