import 'package:flutter/material.dart';



void main() {
//  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
//  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MTest());
}


class Animal{
  var x;
  var y;

/*  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }*/

  //构造函数等同于上面效果
  Animal(this.x, this.y);

  /// 命名构造函数-名构造函数可为一个类实现多个构造函数
  Animal.psOk() {
    x = 0;
    y = 0;
  }


  // 指向主构造函数--有时构造函数的唯一目的是重定向到同一个类中的另一个构造函数。 重定向构造函数的函数体为空， 构造函数的调用在冒号 (:) 之后。
  Animal.alongXAxis(num x) : this(x, 0);//-- 实际会调用这个 Animal(this.x, this.y);


  num addNum(){
    var vx=x+1;
    var vy=y+2;
    return vx+vy;
  }

  num subNum()=> x-y;

}


class Dog extends Animal{
  ///如果父类中没有匿名无参的构造函数， 则需要手动调用父类的其他构造函数。 在当前构造函数冒号 (:) 之后，函数体之前，声明调用父类构造函数。
  Dog.psOk() : super.psOk();
  //Dog(x, y) : super(x, y);


//  通过实现类的 call() 方法， 能够让类像函数一样被调用。
    call(var a,var b,var c)=>'$a与$b and$c合并了';
}

//每个类都隐式的定义了一个接口，接口包含了该类所有的实例成员及其实现的接口
class Cat implements Animal{
  @override
  var x=5;

  @override
  var y=4;

  @override
  num addNum() {
    // TODO: implement addNum
    return x+y;
  }

  @override
  num subNum() {
    // TODO: implement subNum
    return x-y;
  }

}
class MTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}

enum Color { red, green, blue }

 void initData(){
  var p= Animal(1,2);
  var pp=Animal.alongXAxis(1);

  //枚举中的每个值都有一个 index getter 方法， 该方法返回值所在枚举类型定义中的位置（从 0 开始）。 例如，第一个枚举值的索引是 0 ， 第二个枚举值的索引是 1。
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);
  //使用枚举的 values 常量， 获取所有枚举值列表（ list ）
  List<Color> colors = Color.values;
  //colors.length ==3

  //通过实现类的 call() 方法， 能够让类像函数一样被调用。
   var d=new Dog.psOk();
  print(d("小a","小b","小c"));



 }