import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

///ListView是最常用的可滚动widget，它可以沿一个方向线性排布所有子widget。 默认构造函数定义：
/*ListView({
  ...
  //可滚动widget公共参数
  Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  ScrollController controller,
  bool primary,
  ScrollPhysics physics,
  EdgeInsetsGeometry padding,

  //ListView各个构造函数的共同参数
  double itemExtent,
  bool shrinkWrap = false,
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  double cacheExtent,

  //子widget列表
  List<Widget> children = const <Widget>[],
  })*/

///以下属性,并非ListView特有 如girdview等 也可能会有
/*itemExtent：该参数如果不为null，则会强制children的"长度"为itemExtent的值；这里的"长度"是指滚动方向上子widget的长度，即如果滚动方向是垂直方向，
  则itemExtent代表子widget的高度，如果滚动方向为水平方向，则itemExtent代表子widget的长度。在ListView中，指定itemExtent比让子widget自己决定自身长度会更高效，
  这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而不是总是动态去计算，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
 */

/*  shrinkWrap：该属性表示是否根据子widget的总长度来设置ListView的长度，默认值为false 。默认情况下，ListView的会在滚动方向尽可能多的占用空间。
    当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。
 */

/*
  addAutomaticKeepAlives：该属性表示是否将列表项（子widget）包裹在AutomaticKeepAlive widget中；典型地，在一个懒加载列表中，如果将列表项
  包裹在AutomaticKeepAlive中，在该列表项滑出视口时该列表项不会被GC，它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。

  addRepaintBoundaries：该属性表示是否将列表项（子widget）包裹在RepaintBoundary中。当可滚动widget滚动时，将列表项包裹在RepaintBoundary中
  可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。
  和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
*/

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ListView'),
      ),
      body: _addContent(),
    );
  }
}




///(通过一个List来作为其children属性时，只适用于子widget较少的情况)
List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('CineArts at the Empire',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('85 W Portal Ave'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  new Row(
    children: <Widget>[
      new Image.asset('images/img1.png', width: 65, height: 65),
      new Text("嚯嚯哒")
    ],
  )

];


Widget _addContent() {
  return Container(
    child: new MyListview1(),

    ///最基本简单的一个ListView如下：
/*
      ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        //tips: 可滚动widget通过一个List来作为其children属性时，只适用于子widget较少的情况，这是一个通用规律，并非ListView自己的特性，GridView也是如此。

        children: <Widget>[
          const Text('I\'m OK now..'),
          const Text('tips: 可滚动widget通过一个List来作为其children属性时'),
          const Text('只适用于子widget较少的情况，这是一个通用规律'),
          const Text('，并非ListView自己的特性，GridView也是如此。'),
        ],

        //或者引用定义的list：
       // children: list,

      ),
*/

  );
}

///ListView.builder 适合列表项比较多（或者无限）的情况，因为只有当子Widget真正显示的时候才会被创建:
/*
  ListView.builder({
  // ListView公共参数已省略
  @required IndexedWidgetBuilder itemBuilder,
  int itemCount,

  })*/

/*
itemBuilder：它是列表项item的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。当列表滚动到具体的index位置时，会调用该构建器构建列表项。
itemCount：列表项的数量，如果为null，则为无限列表。*/

class MyListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
        itemCount: 20,
        itemExtent: 50.0, //强制time高度为50.0

        //item 构造器(生成item)
        itemBuilder: (BuildContext context, int index) {
          if(index==0){
            //第一个我显示自定义的 布局样式
            return new Row(
              children: <Widget>[
                new Image.asset('images/img1.png', width: 65, height: 65),
                new Text("嚯嚯哒")
              ],
            );

          }else{
            return ListTile(title: Text("这是第$index个"));
          }

        },

        );
  }
}

/// ListView.separated可以生成列表项之间的分割器，比ListView.builder多了一个separatorBuilder参数
class MyListview1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1=Divider(color: Colors.deepOrangeAccent,);
    Widget divider2=Divider(color: Colors.green);

    return ListView.separated(
      physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
      itemCount: 20,
     // itemExtent: 50.0, //强制time高度为50.0  separated里 无法使用这个参数

      //item 构造器(生成item)
      itemBuilder: (BuildContext context, int index) {
        if(index==0){
          //第一个我显示自定义的 布局样式
          return new Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset('images/img1.png', width: 65, height: 65),
                new Text("嚯嚯哒,这是第$index个!")
              ],
            ),
          );

        }else{
          return ListTile(title: Text("这是第$index个!"));
        }

      },

      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index%2==0?divider1:divider2;
      },

    );
  }
}
