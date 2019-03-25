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
        title: new Text('Switch和Checkbox'),
      ),
      body: new SwitchAndCheckBoxTest(),
    );
  }
}

// Switch和Checkbox属性比较简单 至于大小，到目前为止，Checkbox的大小是固定的，无法自定义，而Switch只能定义宽度，高度也是固定的。
// 值得一提的是Checkbox有一个属性tristate ，表示是否为三态，其默认值为false ，这时Checkbox有两种状态即“选中”和“不选中”
// ，对应的value值为true和false ；如果其值为true时，value的值会增加一个状态null

class SwitchAndCheckBoxTest extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTest createState() => new _SwitchAndCheckBoxTest();
}

class _SwitchAndCheckBoxTest extends State<SwitchAndCheckBoxTest> {
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,//当前状态
          activeColor: Colors.blue,
          onChanged:(value){
            //重新构建页面
            setState(() {
              _switchSelected=value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged:(value){
            setState(() {
              _checkboxSelected=value;
            });
          } ,
        )
      ],
    );
  }
}