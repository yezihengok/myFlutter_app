import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      title :'弹性布局Flex',
      home:new MyFlexContnet(),

  ));

}

//弹性布局允许子widget按照一定比例来分配父容器空间 Flex可以沿着水平或垂直方向排列子widget Column都继承自Flex，
// 所以能使用Flex的地方一定可以使用Row或Colum;弹性布局主要通过Flex和Expanded来配合实现。

/*Flex({
 ...
@required this.direction, //弹性布局的方向, Row默认为水平方向，Column默认为垂直方向
List<Widget> children = const <Widget>[],
})*/


//Expanded
//flex为弹性系数，如果为0或null，则child是没有弹性的，即不会被扩伸占用的空间。如果大于0，
// 所有的Expanded按照其flex的比例来分割主轴的全部空闲空间
class MyFlexContnet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        //Flex的两个子widget按1：2来占据水平空间
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1, //flex效果类似于weight 权重
              child: Container(
                height: 35,
                color:  Colors.amber,
              ),
            ),
            Expanded(
              flex: 2, //flex效果类似于weight 权重
              child: Container(
                height: 35,
                color:  Colors.blueAccent,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:10,bottom:10),
          child: SizedBox(
            height: 120,
            //下面Flex的三个子widget，在垂直方向按3：1：1来占用120像素的空间
            child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 30.0,
                      color: Colors.cyan,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.deepOrange[400],
                    ),
                  ),
                ],
            ),
          ),
        )
      ],
    );
  }

}
