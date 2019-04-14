import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/animation/ScaleAnimationRoute2.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
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
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
//      ..addListener(() {
//        setState(() => {});
//      });
    //使用了AnimatedWidget，就不需要监听 每次调用setState去刷新控件了，因为内部已经封装好了setState

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    ///使用了 AnimatedImage 就不用这么写了：
/*    return new Center(
      child: Image.asset("images/avatar.png",
          width: animation.value,
          height: animation.value
      ),
    );*/

    ///使用了 AnimatedBuilder 就不用这么写了：
   /* return AnimatedImage(
      animation: animation,
    );*/

   ///最终简化封装版本:
    return SacleTransition(
//      child: Image.asset("images/img2.png"),

      child:  IconButton(
        icon: Image.asset("images/img2.png"),
        tooltip: '点击跳转 无限循环的放大缩小',
        onPressed:(){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new ScaleAnimationRoute2()));
        }) ,

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




//使用AnimatedWidget简化
//上面示例中通过addListener()和setState() 来更新UI这一步其实是通用的，如果每个动画中都加这么一句是比较繁琐的。
//AnimatedWidget类封装了调用setState()的细节，并允许我们将Widget分离出来:

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("images/img2.png",
          width: animation.value, height: animation.value),
    );
  }
}

///用AnimatedBuilder重构（也是继承于AnimatedWidget的）
//假设我们再添加一个widget透明度变化的动画，那么我们需要再实现一个AnimatedWidget，这样不是很优雅，如果能把渲染过程也抽象出来，
// 那就会好很多:

class SacleTransition extends StatelessWidget {
  SacleTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
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
        ),
      );
  }
}