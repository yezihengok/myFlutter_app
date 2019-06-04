import 'dart:ui';
import 'package:flutter/material.dart';
/**
 * TextStyle:封装
 * colors:颜色
 * fontsizes：字体大小
 * isFontWeight：是否加粗
 */
TextStyle setTextStyle(Color colors,double fontsizes,bool isFontWeight){
  return TextStyle(
    color:colors,
    fontSize: fontsizes,
    fontWeight: isFontWeight == true ? FontWeight.bold : FontWeight.normal ,
  );
}
