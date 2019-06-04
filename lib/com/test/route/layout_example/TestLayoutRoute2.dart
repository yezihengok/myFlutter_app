import 'package:flutter/material.dart';
import 'package:myflutter_app/com/test/styles.dart';

class TestLayoutRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Card列表布局'),
        centerTitle: true,
      ),

      body: Scrollbar(//滚动条
        child: ListView.builder(
            itemCount: 15,
            //itemBuilder是一个匿名回调函数，有两个参数，BuildContext 和迭代器index
            //和ListView的Item项类似 迭代器从0开始 每调用一次这个函数，迭代器就会加1
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  itemWidget,
                ],
              );
            }),
      ),

    );
  }
}

//listviewItem
Widget itemWidget = new Container(
  child: Card(
    clipBehavior: Clip.antiAlias,
    //根据设置检查类容
    color: Colors.grey[100],
    elevation: 10,
    //卡片Z坐标，即阴影大小
    margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //圆角
    //item 整体是个row布局 行
    child: Row(
      mainAxisSize: MainAxisSize.max,
      //主轴上设置从开始方向对齐
      mainAxisAlignment: MainAxisAlignment.start,
      //交叉轴(水平方向)居中
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[itemLeft, itemRight],
    ),
  ),
);

//item 左边部分
Widget itemLeft = new Container(
  //这里使用裁剪实现圆角矩形
  child: ClipRRect(
    borderRadius: BorderRadius.circular(4.0),
    child: Image.network(
      'https://img3.doubanio.com//view//photo//s_ratio_poster//public//p2545472803.webp',
      width: 100,
      height: 140,
      fit: BoxFit.fill,
    ),
  ),
);



//item 右边边部分右布局 用Expanded占满剩余空间
Widget itemRight = Expanded(
  child:Container(
    margin:EdgeInsets.only(left:10.0),
    height:140,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 3),),
        Text("流浪地球", style: setTextStyle(Colors.black, 19, true)),
        Padding(padding: EdgeInsets.only(top: 3),),
        Text("导演：郭帆", style: setTextStyle(Colors.black45, 16, false)),
        Text("豆瓣评分：8.0", style: setTextStyle(Colors.black45, 16, false)),
        Text("类型：科幻、太空、灾难", style: setTextStyle(Colors.black45, 16, false)),
        Container(
          margin: EdgeInsets.only(top: 10),
          //color: Colors.amberAccent,
          child: Row(
            children: <Widget>[
              Text('主演：'),
              //用Row从左到右排列演员
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: getCircleAvator(
                        'https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1540619056.43.webp'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: getCircleAvator(
                        'https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1533348792.03.webp'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: getCircleAvator(
                        'https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1501738155.24.webp'),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  ),
);



//圆形头像 用自带的CircleAvatar这个Widget来实现
CircleAvatar getCircleAvator(String image_url) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    backgroundImage: NetworkImage(image_url),
  );
}
