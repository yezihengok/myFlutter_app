import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyConstrainedBoxContnet(),
  ));
}
//ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的。SizedBox只是ConstrainedBox一个定制

class MyConstrainedBoxContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ConstrainedBox_SizedBox'),
      ),
      body: _buildContnet(),
    );
  }
}
//ConstrainedBox用于对齐子widget添加额外的约束 ，例如让子widget的最小高度是80像素 const BoxConstraints(minHeight: 80.0)作为子widget的约束。

Widget _buildContnet() {
  return Padding(

    padding: EdgeInsets.all(15.0),    //上下左右各添加15像素补白
    child: Column(
      //显式指定对齐方式为左对齐，排除对齐干扰
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
              minHeight: 50 //最小高度为50像素
          ),

          //虽然将Container的高度设置为10像素，但是最终却是50像素，因为ConstrainedBox的最小高度限制生效了
          child: Container(
              height: 10,
              child: blueBox
          ),
        ),

        SizedBox(
            width: 80.0,
            height: 80.0,
            child: redBox
        ),

        //实际上SizedBox和只是ConstrainedBox一个定制，上面代码等同于：
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
          child: blueBox,
        ),

        //多重限制-如果某一个widget有多个父ConstrainedBox限制，那么最终会是哪个生效？
        ///显示效果仍然是宽90，高60. 所以 对于minWidth和minHeight来说，是取父子中相应数值较大的。
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),   //父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),  //子
              child: redBox,
            )
        ),


        //UnconstrainedBox不会对子Widget产生限制允许其子Widget按照其本身大小绘制,一般会很少直接使用此widget，在"去除"多重限制的时候有些作用:

        ///显示的效果为  90×20： 按照子的限制来显示
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60, minHeight: 100),  //父
            child: UnconstrainedBox( //“去除”父级限制
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, minHeight: 20),//子
                child: redBox,
              ),
            )
        )

/*        但是注意，，UnconstrainedBox对父限制的“去除”并非是真正的去除，上面例子中虽然红色区域大小是90×20，
        但上方仍然有80的空白空间。也就是说父限制的minHeight(100.0)仍然是生效的，只不过它不影响最终子元素的大小，但仍然还是占有相应的空间，
        可以认为此时的父ConstrainedBox是作用于子ConstrainedBox上，而redBox只受子ConstrainedBox限制 */


      ],
    ),
  );
}


//定义一个blueBox，它是一个背景颜色为蓝色的盒子，不指定它的宽度和高度：
Widget blueBox=DecoratedBox(decoration: BoxDecoration(color: Colors.blue));
Widget redBox=DecoratedBox(decoration: BoxDecoration(color: Colors.redAccent));
//BoxConstraints还定义了一些便捷的构造函数，用于快速生成特定限制规则的BoxConstraints，如BoxConstraints.tight(Size size)，
//它可以生成给定大小的限制；const BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints