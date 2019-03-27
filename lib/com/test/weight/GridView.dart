import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

//GridView和ListView的大多数参数都是相同的
//唯一需要关注的是 gridDelegate 参数，类型是SliverGridDelegate，它的作用是控制GridView子widget如何排列(layout)
// Flutter中提供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExten

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GridView'),
      ),
      body: _addContent(),
    );
  }
}

///SliverGridDelegateWithFixedCrossAxisCount 该子类实现了一个横轴为固定数量子元素的layout算法
/*SliverGridDelegateWithFixedCrossAxisCount({
  @required double crossAxisCount,
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  double childAspectRatio = 1.0,
  })*/

/*•crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了,即ViewPort横轴长度/crossAxisCount。
  •mainAxisSpacing：主轴方向的间距。
  •crossAxisSpacing：横轴方向子元素的间距。
  •childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。

可以发现，子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的*/

Widget _addContent() {
  return  GridView(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              childAspectRatio: 1.0 //宽高比为1时，子widget
              ),
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast)
          ]);

      ///GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount 上面的代码等价于：
/*      GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      ),*/

}

///SliverGridDelegateWithMaxCrossAxisExtent 该子类实现了一个横轴子元素为固定最大长度的layout算法，其构造函数为：
/*SliverGridDelegateWithMaxCrossAxisExtent({
  double maxCrossAxisExtent,
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  double childAspectRatio = 1.0,
  })*/

//maxCrossAxisExtent 为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的，举个例子，
//如果ViewPort的横轴长度是450，那么当maxCrossAxisExtent的值在区间(450/4，450/3]内的话，子元素最终实际长度都为150，而
//childAspectRatio 所指的子元素横轴和主轴的长度比为最终的长度比。其它参数和SliverGridDelegateWithFixedCrossAxisCount相同。

Widget _addContent2() {
  return GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120.0, childAspectRatio: 2.0 //宽高比为2
            ),
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      );

      ///GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent 上面的代码等价于：
/*      GridView.extent(
        maxCrossAxisExtent: 120.0,
        childAspectRatio: 2.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      )*/

}
