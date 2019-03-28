import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/eventbus/EventBus.dart';
import 'package:myflutter_app/com/test/eventbus/SecondRoute.dart';
import 'package:myflutter_app/com/test/eventbus/UserInfo.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new LoginRoute(),
  ));
}

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('输入框and表单'),
      ),
      body: FormTest(),
    );
  }
}


class FormTest extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTest> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true, //获取默认焦点
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空!";
                  }),

              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "输入登录密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位哦~";
                  }),

              /// 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过Form.of(context)方式获取FormState，context不对
                          //不能通过Form.of(context)来获取，原因是，此处的context为FormTest的context，
                          // 而Form.of(context)是根据所指定context向根去查找，而FormState是在FormTestRoute的子树中，所以不行

                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {

                            print("验证通过~~");



                            ///监听订阅登录事件    (其他路由 调用 mBus.emit("login", user)会执行)
                            mBus.on("login", (arg) {

                              //tips: arg 泛型  as等同于强转为 UserInfo类型
                              var msg=(arg as UserInfo).toString();

                              print("登录界面订阅的事件执行了:$msg");
                            });


                            UserInfo info=new UserInfo(_nameController.text, _pwdController.text);
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondRoute(info)));
                          }
                        },
                      ),
                    ),


                    ///要正确的使用 Form.of(context) 正确的做法是通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数：
                   /* Expanded(
                        // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                        child: Builder(builder: (context) {
                      return RaisedButton(
                        onPressed: () {
                          //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                          if (Form.of(context).validate()) {
                            //验证通过提交数据
                            print("验证通过！！！！");
                          }
                        },
                      );
                    }))*/


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
