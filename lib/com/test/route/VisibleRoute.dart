import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisibleRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _VisibleRouteState();
  }
}

class _VisibleRouteState extends State<VisibleRoute> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('widget显示与隐藏'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text(visible ? '显示A 隐藏B  ' : '隐藏A 显示B'),
                onPressed: () {
                  visible = !visible;
                  setState(() {});
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top:5, right: 10.0),
            child: new Stack(
              children: <Widget>[
                new TestAWidget(
                  visible: visible,
                ),
                new TestBWidget(
                  visible: !visible,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




class TestAWidget extends StatelessWidget {
  final bool visible;

  const TestAWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: new Container(
        color: Colors.blue,
        height: 100.0,
        child: new Center(
          child: new Text('AWidget'),
        ),
      ),
    );
  }
}

class TestBWidget extends StatelessWidget {
  final bool visible;

  const TestBWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: new Container(
        color: Colors.green,
        height: 100.0,
        child: new Center(
          child: new Text('BWidget'),
        ),
      ),
    );
  }
}


