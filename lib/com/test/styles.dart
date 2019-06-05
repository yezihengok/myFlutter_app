import 'dart:ui';
import 'package:flutter/material.dart';

/**
 * TextStyle:封装
 * colors:颜色
 * fontsizes：字体大小
 * isFontWeight：是否加粗
 */
TextStyle setTextStyle(Color colors, double fontsizes, bool isFontWeight) {
  return TextStyle(
    color: colors,
    fontSize: fontsizes,
    fontWeight: isFontWeight == true ? FontWeight.bold : FontWeight.normal,
  );
}

//圆形头像 用自带的CircleAvatar这个Widget来实现
CircleAvatar getCircleAvator(String image_url) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    backgroundImage: NetworkImage(image_url),
  );
}

/**
 * 显示'加载更多FootView
 */
Widget getFootViewWidget(var content,bool hideProgress) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              content,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.0,
              )),
          new Offstage(
            // widget 根据offstage这个值来决定显示(false)还是隐藏(true)
            offstage: hideProgress,
            //加载圆圈
            child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(strokeWidth: 2.0)),
          )
        ],
      ),
    ),
  );
}
