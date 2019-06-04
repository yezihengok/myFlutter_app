import 'package:flutter/material.dart';

class TestLayoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('实践Flutter中文网布局的例子'),
        centerTitle: true,
      ),
      body: new Scrollbar(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                children: <Widget>[
                  new Image.asset('images/banner.jpg', width: 450, height: 150,
                    fit:BoxFit.cover,),
                  titleLayout,
                  buttonLayout,
                  txtContentLayot
                ],
              ))),
    );
  }
}

//标题部分
Widget titleLayout = new Container(
  padding: EdgeInsets.all(20),
  child: Row(
    children: <Widget>[
      //用Expanded 会占用右边icon之外剩余空间
      Expanded(
        //垂直布局 放置两个文本
        child: Column(
          //文本一起始端对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          //有两个文本
          children: <Widget>[
            Padding(
              //底部内边距
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "特朗普即将宣布连任2020年将开启美国下一个新时代.",
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "时间:2019年6月4日10:44:43",
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),

      new Icon(
        Icons.star,
        color: Colors.pinkAccent,
      ),
      new Text('42'),
    ],
  ),
);

Widget buttonLayout = new Container(
  //行
  child: Row(
    //用MainAxisAlignment.spaceEvenly平均分配子空间
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      getButton(Icons.call, "打电话"),
      getButton(Icons.email, "发邮件"),
      getButton(Icons.share, "分享"),
    ],
  ),
);

Column getButton(IconData icondata, String text) {
  return Column(
    //聚集widgets
    mainAxisSize: MainAxisSize.min,
    //child居中
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        icondata,
        color: Colors.blue[400],
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(text, style: TextStyle(color: Colors.blue[400]),),

      ),


    ],
  );
}

Widget txtContentLayot=new Container(
  alignment: Alignment.center,
  //设置内边距
  padding:const EdgeInsets.all(12.0),
    child:new Text(
          '   央广网北京2月28日消息 据中国之声《新闻晚高峰》报道，距离2020年再一次美国大选还有1年多的时间，'
          '早早宣布谋求连任的美国总统特朗普，已经开始了他的竞选布局。当地时间27日，'
          '特朗普宣布，他决定任命自己2016年竞选团队的数字媒体主管布拉德·帕斯卡尔担任连任竞选团队经理。'
          '和过去几任美国总统相比，特朗普谋求连任的布局，似乎铺开得更早一些。伴随着特朗普的连任竞选团队确定，大选造势工作似乎已经箭在弦上...',
       softWrap: true,//属性表示文本是否应在软换行符（例如句点或逗号）之间断开。
      // textAlign: TextAlign.center,
    ),

);


