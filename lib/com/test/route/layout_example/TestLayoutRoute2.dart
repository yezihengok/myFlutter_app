import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutter_app/com/test/bean/MovieInfo.dart';
import 'package:myflutter_app/com/test/styles.dart';

List<MovieInfo> _getmovieList() {
  List<MovieInfo> list = new List();
  for (var i = 0; i < 10; i++) {
    MovieInfo info;

    if (i % 2 == 0) {
      info = new MovieInfo("郭帆", 7.9, "科幻/太空/灾难", "流浪地球",
          "https://img3.doubanio.com//view//photo//s_ratio_poster//public//p2545472803.webp");
      List<String> actors = [
        "https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1540619056.43.webp",
        "https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1533348792.03.webp",
        "https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1501738155.24.webp"
      ];
      info.actors = actors;
    } else {
      info = new MovieInfo("迈克尔·道赫蒂", 6.5, "动作/科幻/冒险/灾难", "哥斯拉2：怪兽之王",
          "https://img3.doubanio.com/view/photo/l/public/p2554370800.webp");
      List<String> actors = [
        "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p34972.webp",
        "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1359895311.0.webp",
        "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p11871.webp",
        "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p20877.webp"
      ];
      info.actors = actors;
    }
    list.add(info);
  }
  return list;
}

class TestLayoutRoute2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TestLayoutRoute2State();
  }
}

class _TestLayoutRoute2State extends State<TestLayoutRoute2> {
  //ListView控制器
  ScrollController _controller = ScrollController();
  List<MovieInfo> list = new List();

  @override
  void initState() {
    super.initState();
    print('initState（）');
    _pullToRefresh();

    //添加监听列表是否滑动到底部，然后上拉加载
    _controller.addListener(() {
      //这里判断滑到底部第一个条件就可以了，加上不在刷新和不是上滑加载
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('滑动到了底部');
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //State删除对象时调用Dispose， 移除监听避免内存泄漏
    _controller.dispose();
  }

//下拉刷新
  Future<Null> _pullToRefresh() async {
    print('下拉刷新--');
    //等待延时2S后再关闭
    await Future.delayed(Duration(seconds: 1), () {
      list.clear();
      list = _getmovieList();
      setState(() {
        Fluttertoast.showToast(msg: "重置10条数据");
        return null;
      });
    });
  }

  bool isLoading = false; //是否正在上拉加载数据
//上拉加载
  void _getMoreData() async {
    print('进入上拉加载--');

    if (!isLoading) {
      if (list.length <= 20) {
        //测试--最多加载30条，超过30条不在加载
        setState(() {
          isLoading = true;
        });

        await Future.delayed(Duration(seconds: 1)).then((e) {
          list.addAll(_getmovieList());
          setState(() {
            //重新构建列表
            Fluttertoast.showToast(msg: "已加载10条数据");
            isLoading = false;
          });
        });
      } else {
        Fluttertoast.showToast(msg: "没有更多了");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('列表布局示例--${list.length}'),
        centerTitle: true,
      ),
      //RefreshIndicator -flutter自带的下拉刷新Indicator，RefreshIndicator的child 一定必须包含可滑动的widget
      body: RefreshIndicator(
        //key: _refreshIndicatorKey,
        onRefresh: _pullToRefresh,
        child: _listview(),
      ),
    );
  }

  Widget _listview() {
    return Scrollbar(
      //滚动条
      child: ListView.builder(
          //设置physics属性总是可滚动(主要是解决 数据不满一屏幕时，无法滑动出发下拉刷新)
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: list.isEmpty ? 0 : list.length + 1,
          // 加上尾部加载更多实际itemCount需要+1
          //控制器 上拉加载
          controller: _controller,

          //itemBuilder是一个匿名回调函数，有两个参数，BuildContext 和迭代器index
          //和ListView的Item项类似 迭代器从0开始 每调用一次这个函数，迭代器就会加1
          itemBuilder: mItemBuilder),
    );
  }

  //加载listview Item
  Widget mItemBuilder(BuildContext context, int index) {
    if (index < list.length) {
      print("总共：${list.length} 当前是第:$index条数据");
      return new Container(
        //很多控件不像RaisedButton、OutlineButton等自带监听事件。那么如果要监听这些控件的手势就需要用另一个控件GestureDetector
        child: GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: "你点击了【${list[index].name}】");
          },

          child: Card(
            clipBehavior: Clip.antiAlias,
            //根据设置检查类容
            color: Colors.grey[100],
            elevation: 10,
            //卡片Z坐标，即阴影大小
            margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //圆角
            child: Row(
              //item 整体是个row布局 行
              mainAxisSize: MainAxisSize.max,
              //主轴上设置从开始方向对齐
              mainAxisAlignment: MainAxisAlignment.start,
              //交叉轴(水平方向)居中
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[itemLeft(list[index]), itemRight(list[index])],
            ),

          ),
        ),


      );
    } else {
      print("总共：${list.length} 当前需要显示的下标:$index ,超过实际list，显示加载中");
      if (list.length < 30) {
        return getFootViewWidget('加载中...', false);
      } else {
        return getFootViewWidget('————已经到底啦————', true);
      }
    }
  }
}

//item 左边部分
Widget itemLeft(MovieInfo info) {
  return new Container(
    //这里使用裁剪实现圆角矩形
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.network(
        info.picUrl,
        width: 100,
        height: 148,
        fit: BoxFit.fill,
      ),
    ),
  );
}

//item 右边边部分右布局 用Expanded占满剩余空间
Widget itemRight(MovieInfo info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 148,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 3),
          ),
          Text(info.name, style: setTextStyle(Colors.black, 19, true)),
          Padding(
            padding: EdgeInsets.only(top: 3),
          ),
          Text("导演：${info.director}",
              style: setTextStyle(Colors.black45, 16, false)),
          Text("豆瓣评分：${info.score}",
              style: setTextStyle(Colors.black45, 16, false)),
          Text("类型：${info.type}",
              style: setTextStyle(Colors.black45, 16, false)),
          Container(
            margin: EdgeInsets.only(top: 10),
            //color: Colors.amberAccent,
            child: Row(
              children: <Widget>[
                Text('主演：'),
                //用Row从左到右排列演员
                Row(
                  children: _actorWidgets(info),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//演员头像集合
List<Widget> _actorWidgets(MovieInfo info) {
  List<Widget> widgets = new List<Widget>();
  List<String> list = info.actors;
  for (var i = 0; i < list.length; i++) {
    widgets.add(new Container(
      margin: EdgeInsets.only(left: 15),
      child: getCircleAvator(info.actors[i]),
    ));
  }
  return widgets;
}
