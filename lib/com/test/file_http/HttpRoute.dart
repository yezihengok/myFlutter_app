import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myflutter_app/com/test/file_http/HttpUtils.dart';
import 'package:myflutter_app/com/test/bean/Values.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Widget',
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('http_DIO'),
      ),
      //   body: ScrollControllerTestRoute(),

      body: HttpRoute(),
    ),
  ));
}

const  String BaseUrl = "http://www.wanandroid.com/";

class HttpRoute extends StatefulWidget {
  @override
  _HttpTestState createState() => new _HttpTestState();
}
class _HttpTestState extends State<HttpRoute>{
  String _msg="";
  String _login="";
  String _testJson="";
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics:BouncingScrollPhysics(),//ios滑动到边界回弹效果
        //physics:ClampingScrollPhysics(),//android滑动到边界弧形微光效果
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                child: Text("点击get返回:\n$_msg"),
                onPressed: _getBanner,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text("测试对象转换为json字符串:\n$_testJson"),
                  onPressed: _tsetJson,
                ),
              ),
              RaisedButton(
                child: Text("点击post返回:\n$_login"),
                onPressed: _toSearch,
              ),

            ],
          ),
        ),
      ),
    );

  }

  ///测试get  请求
  _getBanner(){
    httpUtils.getHttp("banner/json", (callback){
      if(callback!=null){
        setState(() {
          _msg=callback;
        });
      }
    });
  }
///测试post
  _toSearch(){
    Values info=new Values(0,"10","老司机");
    httpUtils.postHttp("http://api.jiefu.tv/app2/api/dt/shareItem/search.html",info, (callback){
      if(callback!=null){
        setState(() {
          _login=callback;
        });
      }
    });
  }

  _tsetJson(){
    setState(() {
      _testJson=new Values(1,"11","老司机开车啦").toJsons();
    });
  }
}





