import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

///可滚动Widget：公用属性介绍：
///SingleChildScrollView、ListView、GridView 等都直接或间接包含Scrollable 因此它们都有一些共同的属性：

  /*Scrollable({

  this.axisDirection = AxisDirection.down,
  this.controller,
  this.physics,
  @required this.viewportBuilder, //后面说明
  })*/

  /*
  axisDirection：滚动方向。

  physics：此属性接受一个ScrollPhysics对象，默认情况下，Flutter会根据具体平台分别使用不同的ScrollPhysics对象， 如在iOS上会出现弹性效果，
//  physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
//physics:ClampingScrollPhysics(),//android滑动到边界弧形微光效果


  controller：此属性接受一个ScrollController对象。ScrollController的主要作用是控制滚动位置和监听滚动事件。默认情况下，widget树中会有一个
  默认的PrimaryScrollController，如果子树中的可滚动widget没有显式的指定controller并且primary属性值为true时（默认就为true），
  可滚动widget会使用这个默认的PrimaryScrollController，这种机制带来的好处是父widget可以控制子树中可滚动widget的滚动，例如，Scaffold使用这
  种机制在iOS中实现了"回到顶部"的手势。 后面“滚动控制” ScrollController.dart里在详细学习。*/

///  Scrollbar 是一个Material风格的滚动指示器（滚动条）
///要给可滚动widget添加滚动条，只需将Scrollbar作为可滚动widget的父widget即可：
/*  Scrollbar(
    child: SingleChildScrollView(
  ),
  );*/
///ViewPort视口
//指一个Widget的实际显示区域。例如，一个ListView的显示区域高度是800像素，虽然其列表项总高度可能远远超过800像素，但是其ViewPort仍然是800像素。


class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SingleChildScrollView'),
      ),
      body: _addContent(),
    );
  }
}


//SingleChildScrollView(类似于Android中的ScrollView)
  /*SingleChildScrollView({
  this.scrollDirection = Axis.vertical, //滚动方向，默认是垂直方向
  this.reverse = false,
  this.padding,
  bool primary,
  this.physics,
  this.controller,
  this.child,
  }) */

///除了通用属性主要看这两个:
/*reverse：该属性API文档解释是：是否按照阅读方向相反的方向滑动，如：scrollDirection值为Axis.horizontal，如果阅读方向是从左到右(取决于语言环境，阿拉伯语就是从右到左)
，reverse为true时，那么滑动方向就是从右往左。其实此属性本质上是决定可滚动widget的初始滚动位置是在“头”还是“尾”，取false时，初始滚动位置在“头”，反之则在“尾”，读者可以自己试验。

primary：指是否使用widget树中默认的PrimaryScrollController；当滑动方向为垂直方向（scrollDirection值为Axis.vertical）并且controller没有指定时，primary默认为true.*/

Widget _addContent() {
  String str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      child: SingleChildScrollView(
          physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
          //physics:ClampingScrollPhysics(),//android滑动到边界弧形微光效果
          padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            ////动态创建一个List<Widget>
            children: str.split("")
                ////每一个字母都用一个Text显示,字体为原来的1.8倍
                .map((t)=> Text(t,textScaleFactor: 1.8,)).toList(),
          ),
        ),
      ),
    );
}
