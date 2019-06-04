package com.yzh.myflutter_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    //设置状态栏透明
//    if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.LOLLIPOP)
//    {
//        //API>21,设置状态栏颜色透明
//      getWindow().setStatusBarColor(0);
//    }
    GeneratedPluginRegistrant.registerWith(this);
  }
}
