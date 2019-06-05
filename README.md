# myflutter_app
Flutter简介

Flutter 是 Google推出并开源的移动应用开发框架，主打跨平台、高保真、高性能。开发者可以通过 Dart语言开发 App，一套代码同时运行在 iOS 和 Android平台。
 Flutter提供了丰富的组件、接口，开发者可以很快地为 Flutter添加 native扩展。同时 Flutter还使用 Native引擎渲染视图...

## 这里记录的是日常学习练手的demo

**-----包分类：**
* com.test.animation                    ---动画部分
* com.test.container                    ---容器类Widget
* com.test.event_notification           ---手势识别、原始指针事件 功能性Widget
* com.test.eventbus                     ---模拟登陆的 回调事件总线
* com.test.file_http                    ---flutter 中http请求接口(使用dio)
* com.test.layout                       ---布局类widget Column、Row等基本 使用
* com.test.route                        ---路由跳转传值（路由route等同于 Android里的页面activity概念）
* com.test.weight                       ---图片、按钮、列表等基本控件使用


**-----Tips：**
*容器类Widget container

容器类Widget和布局类Widget都作用于其子Widget，不同的是：
布局类Widget一般都需要接收一个widget数组（children），他们直接或间接继承自（或包含）MultiChildRenderObjectWidget ；而容器类Widget一般只需要接受一个子Widget（child），他们直接或间接继承自（或包含）SingleChildRenderObjectWidget。
布局类Widget是按照一定的排列方式来对其子Widget进行排列；而容器类Widget一般只是包装其子Widget，对其添加一些修饰（补白或背景色等）、变换(旋转或剪裁等)、或限制(大小等)。


* ### [基本的上拉下拉加载listview]：
![Doutu-master](https://github.com/yezihengok/myFlutter_app/blob/master/screenshots/device_0.png)

*### [截图1]：
![Doutu-master](https://github.com/yezihengok/myFlutter_app/blob/master/screenshots/device_1.png)

* ###[代码注释截图]：
![Doutu-master](https://github.com/yezihengok/myFlutter_app/blob/master/screenshots/device_2.png)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
