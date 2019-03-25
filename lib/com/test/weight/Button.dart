import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyContnet(),
  ));
}

//Material widget库中提供了多种按钮Widget如RaisedButton、FlatButton、OutlineButton等，它们都是直接或间接对RawMaterialButton的包装定制

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Button'),
      ),
      body: _buildContnet(),
    );
  }
}

  ///属性：
  /*const FlatButton({
  ...
  @required this.onPressed, //按钮点击回调
  this.textColor, //按钮文字颜色
  this.disabledTextColor, //按钮禁用时的文字颜色
  this.color, //按钮背景颜色
  this.disabledColor,//按钮禁用时的背景颜色
  this.highlightColor, //按钮按下时的背景颜色
  this.splashColor, //点击时，水波动画中水波的颜色
  this.colorBrightness,//按钮主题，默认是浅色主题
  this.padding, //按钮的填充
  this.shape, //外形
  @required this.child, //按钮的内容
  })*/
Widget _buildContnet() {
  return Column(

    children: <Widget>[
      RaisedButton(
        child: Text("RaisedButton"),//RaisedButton 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
        onPressed: () => {},
      ),
      FlatButton(
        child: Text("FlatButton"),//FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色：
        onPressed: () => {},
      ),
      OutlineButton(
        child: Text("OutlineButton"),//OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮
        onPressed: () => {},
      ),
      IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () => {},
      ),

      //自定义一个button  ,要阴影改为 RaisedButton
      FlatButton(
        color: Colors.blue,
        highlightColor: Colors.blue[700],
        colorBrightness: Brightness.dark,//因为按钮背景是深色 colorBrightness为Brightness.dark，这是为了保证按钮文字颜色为浅色。
        splashColor: Colors.grey,
        child: Text("按钮"),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () => {},
      ),

    ],
  );
}
