import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyFlowContnet(),
  ));
}


class MyFlowContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flow-类似于ViewGroup重写onLayout()决定子View布局'),
      ),
      body: _buildWarpContnet(),
    );
  }
}

/*一般较少会使用Flow，使用略微复杂，需要自己实现子widget的位置转换，在很多场景下首先要考虑的是Wrap是否满足需求。

Flow主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景。Flow有如下优点：
性能好；Flow是一个对child尺寸以及位置调整非常高效的控件，Flow用转换矩阵（transformation matrices）在对child进行位置调整的时候进行了优化：
在Flow定位过后，如果child的尺寸或者位置发生了变化，在FlowDelegate中的paintChildren()方法中调用context.paintChild 进行重绘，
而context.paintChild在重绘时使用了转换矩阵（transformation matrices），并没有实际调整Widget位置。

灵活；由于我们需要自己实现FlowDelegate的paintChildren()方法，所以我们需要自己计算每一个widget的位置，因此，可以自定义布局。
缺点：
使用复杂.
不能自适应子widget大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。*/

Widget _buildWarpContnet() {
  return Flow(
    delegate: MyFlowDelegate(margin: EdgeInsets.all(10.0)),
    children: <Widget>[
      new Container(width: 100.0, height:100.0, color: Colors.amber,),
      new Container(width: 100.0, height:100.0, color: Colors.blue,),
      new Container(width: 100.0, height:100.0, color: Colors.cyan,),
      new Container(width: 100.0, height:100.0,  color: Colors.deepOrange,),
      new Container(width: 100.0, height:100.0, color: Colors.greenAccent,),
      new Container(width: 100.0, height:100.0,  color: Colors.purpleAccent,),
    ],
  );
}

class MyFlowDelegate extends FlowDelegate{
  EdgeInsets margin = EdgeInsets.zero;
  MyFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // 实现paintChildren，确定每个子widget位置 类似于ViewGroup的onLayout()
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置  
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)  
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints){
    //指定Flow的大小
    return Size(double.infinity,240.0);
  }
  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }

}



