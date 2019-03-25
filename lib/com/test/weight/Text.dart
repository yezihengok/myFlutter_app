import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Text'),
      ),
      body: _buildWarpContnet(),
    );
  }
}


// 声明一个文本样式
const textStyle = const TextStyle(
  color: Colors.deepOrange,
  fontSize: 18.0,
  decoration: TextDecoration.underline,
);

Widget _buildWarpContnet() {
  return Column(
    children: <Widget>[
      Text(
        "嚯嚯哒",
        textAlign:
            TextAlign.center, //textAlign：文本的对齐方式 (只有Text宽度大于文本内容长度时指定此属性才有意义)
      ),
      Text(
        "呵呵哒;" * 10,
        maxLines: 1,
        overflow: TextOverflow.ellipsis, //最多显示1行 ，显示不完 省略号“...”表示
      ),
      Text(
        "咯咯哒",
        style: textStyle,
        textScaleFactor: 1.5, //缩放文字1.5倍
      ),
      Text(
        "我是一个文本",
        style: TextStyle(
            color: Colors.blue,
            fontSize: 18.0,
            height: 1.2, //行高
            fontFamily: "Courier",
            background: new Paint()..color = Colors.cyanAccent,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed),
      ),


      Text.rich(TextSpan(children: [
        TextSpan(text: "Address: "),
        TextSpan(
          text: "https://www.baidu.com",
          style: TextStyle(color: Colors.blue),
          // recognizer: _tapRecognizer  //recognizer，手势识别 它是点击链接后的一个处理器
        ),
      ])),


      ///在widget树中，文本的样式默认是可以被继承的，如果在widget树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式
      DefaultTextStyle(
        //1.设置文本默认样式
        style: TextStyle(
          color: Colors.red,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("阿里爸爸"),
            Text("阿里妈妈"),
            Text(
              "非阿里系 ",
              style: TextStyle(
                  inherit: false, //2.不继承默认样式
                  color: Colors.grey),
            ),
          ],
        ),
      ),

    ],
  );
}
