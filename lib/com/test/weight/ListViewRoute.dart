import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(new MaterialApp(
    title: 'listtitle',
    home: new ListViewRoute(),
  ));
}

class ListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('一个简易版可上拉下拉加载的Listview'),
      ),
      body: new InfiniteListView(),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const endTag = "--END--"; //表尾标记
  var _words = <String>[endTag];

  @override
  void initState() {
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
      //RefreshIndicator -flutter自带的下拉刷新Indicator，RefreshIndicator的child 一定必须包含可滑动的widget
    var _refreshIndicator = new RefreshIndicator(
      //key: _refreshIndicatorKey,
      onRefresh: _pullToRefresh,
      child: _listview(),
    );

    return _refreshIndicator;

  }



  //加载listview 相关
  Widget _listview(){
      return Column(children: <Widget>[
        ListTile(title:Text("商品列表headView")),//在listview头部添加一个item

        //直接如下写会报错: 因为ListView高度边界无法确定了
/*      ListView.builder(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      }),*/

        //使用Expanded自动拉伸ListView组件大小
        Expanded(
          child: ListView.separated(

            //设置physics属性总是可滚动(主要是解决 数据不满一屏幕时，无法滑动出发下拉刷新)
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: _words.length,
            itemBuilder: (context, index) {
              //如果到了表尾
              if (_words[index] == endTag) {
                //不足100条，继续获取数据
                if (_words.length - 1 < 100) {
                  //获取数据
                  _retrieveData();
                  //加载时显示loading
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg:"已加载100个单词，不可上拉了~");
                  //已经加载了100条数据，不再获取数据。
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
                  );


                }
              }
              //显示单词列表项
              return ListTile(title: Text(_words[index]));
            },
            separatorBuilder: (context, index) => Divider(height: .0),
          ),
        ),
      ]);
  }





  //下拉刷新
  Future<Null> _pullToRefresh() async {

    _words.clear();

    _words.insertAll(0, generateWordPairs().take(20).map((e) => e.asLowerCase).toList());    //生成20个单词
    _words.add(endTag);
    //等待延时2S后再关闭
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {

        Fluttertoast.showToast(msg:"重置生成20个小写单词");
        return null;
      });
    });



  }


  //上拉加载
  void _retrieveData() async {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
      );
      setState(() {
        //重新构建列表
      });
    });
  }

}

