import 'package:flutter/material.dart';

class ToastUtils{

  static GlobalKey<ScaffoldState> scaffoldKey;

  //吐司
  static showToast(String msg) {
    if(scaffoldKey==null){
      scaffoldKey = new GlobalKey<ScaffoldState>();
    }
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }

  //打印日志
  static showPrint(String msg){
    if(msg!=null){
      print("log-----" + msg);
    }
  }

}