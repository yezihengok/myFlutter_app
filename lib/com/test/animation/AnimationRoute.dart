import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/animation/ScaleAnimationRoute.dart';
import 'package:myflutter_app/com/test/animation/bar_animation_route.dart';

class AnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AnimationRouteState();
  }
}

class _AnimationRouteState extends State<AnimationRoute> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('动画Animation'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('ScaleAnimationRoute '),
                onPressed: () {
                  Navigator.push(context, new CupertinoPageRoute(builder: (context) => new ScaleAnimationRoute()));
                }),
          ),

          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('bar_animation '),
                onPressed: () {
                  Navigator.push(context, new CupertinoPageRoute(builder: (context) => new bar_animation_route()));
                }),
          ),

        ],
      ),
    );
  }
}






