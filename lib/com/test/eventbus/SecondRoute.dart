import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/eventbus/EventBus.dart';
import 'package:myflutter_app/com/test/eventbus/UserInfo.dart';

class SecondRoute extends StatelessWidget {


  UserInfo  _userInfo;


   SecondRoute(this._userInfo);
  // SecondScreen({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final msg=_userInfo?.toString();

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("第二个页面"),

      ),
      body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                   Navigator.pop(context);
                },
                child: new Text('传过来的值:$msg',
                ),
              ),

              RaisedButton(
                onPressed: () {
                  //点击后后触发订阅的登录事件，页面A中订阅者会被调用
                  UserInfo user=new UserInfo(_userInfo.username+"_update", _userInfo.password+"_update");//修改一下内容在丢给订阅者
                  mBus.emit("login", user);
                },
                child: new Text('点我登录界面订阅的事件会执行',
                ),
              ),

            ],
          ),

      ),
    );
  }
}