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
        title: new Text('输入框and表单'),
      ),
      body: _addContent(),
    );
  }
}

//TextField用于文本输入，它提供了非常多属性：
/*
controller：编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。

focusNode：用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个handle。

InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等。

keyboardType：用于设置该输入框默认的键盘输入类型，取值如下：

| TextInputType枚举值 | 含义 | | ------------------- | --------------------------------------------------- | | text | 文本输入键盘 | | multiline | 多行文本，需和maxLines配合使用(设为null或大于1) | | number | 数字；会弹出数字键盘 | | phone | 优化后的电话号码输入键盘；会弹出数字键盘并显示"* #" | | datetime | 优化后的日期输入键盘；Android上会显示“: -” | | emailAddress | 优化后的电子邮件地址；会显示“@ .” | | url | 优化后的url输入键盘； 会显示“/ .” |

textInputAction：键盘动作按钮图标(即回车键位图标)，它是一个枚举值，有多个可选值，全部的取值列表读者可以查看API文档，TextInputAction.search 为搜索
style：正在编辑的文本样式。
textAlign: 输入框内编辑文本在水平方向的对齐方式。
autofocus: 是否自动获取焦点。
obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
maxLines：输入框的最大行数，默认为1；如果为null，则无行数限制。
maxLength和maxLengthEnforced ：maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。
onChange：输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。
onEditingComplete和onSubmitted：这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标）。不同的是两个回调签名不同，onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。
inputFormatters：用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。
enable：如果为false，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。
cursorWidth、cursorRadius和cursorColor：这三个属性是用于自定义输入框光标宽度、圆角和颜色的*/

Widget _addContent() {
  //定义一个controller 通过controller可获得 文本   print(_nameController.text);
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  //controller 可设置一些默认值
  _nameController.text = "我是默认的值";
  //设置默认值，并从第4个字符开始选中后面的字符
  _nameController.selection =
      TextSelection(baseOffset: 3, extentOffset: _nameController.text.length);

  //通过controller也可监听 文本变化
  _pwdController.addListener(() {
    print(_pwdController.text);
  });

  return new ListView(
    children: <Widget>[
      Column(
        children: <Widget>[
          TextField(
              controller: _nameController, //设置controller
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),

              //监听文本变化可用onChanged 也可用controller监听
              onChanged: (v) {
                print("onChange: $v");
              }),
          TextField(
            controller: _pwdController, //设置controller
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)),
            obscureText: true,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new FocusTest(),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new FocusTest1(),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new FormTest(),
        ],
      ),
    ],
  );
}

///控制焦点
///焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理，它代表焦点控制范围，
///可以在这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等。我们可以通过FocusScope.of(context)
/// 来获取widget树中默认的FocusScopeNode
class FocusTest extends StatefulWidget {
  @override
  _FocusTestState createState() => new _FocusTestState();
}

class _FocusTestState extends State<FocusTest> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    //监听焦点状态改变事件
    focusNode1.addListener(() {
      print("输入框1焦点:" + focusNode1.hasFocus.toString());
    });

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1, //关联focusNode1
            decoration: InputDecoration(labelText: "输入框1"),
          ),
          TextField(
            focusNode: focusNode2, //关联focusNode2
            decoration: InputDecoration(labelText: "输入框2"),
          ),
          Builder(
            builder: (ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);

                      // 第二种写法
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

///自定义样式
///由于TextField在绘制下划线时使用的颜色是主题色里面的hintColor，但提示文本颜色也是用的hintColor，
/// 如果我们直接修改hintColor，那么下划线和提示文本的颜色都会变。但是decoration中可以设置hintStyle，
/// 它可以覆盖hintColor，并且主题中可以通过inputDecorationTheme来设置输入框默认的decoration。所以我们可以通过主题来自定义
class FocusTest1 extends StatefulWidget {
  @override
  _FocusTestState1 createState() => new _FocusTestState1();
}

class _FocusTestState1 extends State<FocusTest1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Theme(
          data: Theme.of(context).copyWith(
              hintColor: Colors.grey[200], //定义下划线颜色
              inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                  )),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    // labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "密码",
                    hintText: "您的登录密码",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
                obscureText: true,
              ),
              Container(
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "电子邮件地址",
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none //隐藏获取焦点时的下划线
                        )),
                decoration: BoxDecoration(
                    // 下滑线浅灰色，宽度1像素
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey[200], width: 1.0))),
              )
            ],
          )),
    );
  }
}

///Form:

/* autovalidate：是否自动校验输入内容；当为true时，每一个子FormField内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。
   onWillPop：决定Form所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个Future对象，如果Future的最终结果是false，则当前路由不会返回；如果为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。
   onChanged：Form的任意一个子FormField内容发生变化时会触发此回调。*/

///为了方便使用，Flutter提供了一个TextFormField,它继承自FormField类，也是TextField的一个包装类，所以除了FormField定义的属性之外，它还包括TextField的属性。
/*const FormField({
  ...
  FormFieldSetter<T> onSaved, //保存回调
  FormFieldValidator<T>  validator, //验证回调
  T initialValue, //初始值
  bool autovalidate = false, //是否自动校验。
  })*/

///FormState 为Form的State类 可以通过Form.of()或GlobalKey获得。我们可以通过它来对Form的子孙FormField进行统一操作
/*FormState.validate()：调用此方法后，会调用Form子孙FormField的validate回调，如果有一个校验失败，则返回false，所有校验失败项都会返回用户返回的错误提示。
    FormState.save()：调用此方法后，会调用Form子孙FormField的save回调，用于保存表单内容
    FormState.reset()：调用此方法后，会将子孙FormField的内容清空。*/

///一个完整的登录校验案例:
///用户名不能为空，如果为空则提示“用户名不能为空”。
///密码不能小于6位，如果小于6为则提示“密码不能少于6位”
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
