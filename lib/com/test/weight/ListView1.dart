import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() {
  runApp(new MaterialApp(
    title: 'listtitle',
    home: new MyContnet(),
  ));
}

class MyContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('无限加载的Listview'),
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
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
      ListTile(title:Text("商品列表")),//在listview头部添加一个item

      //直接如下写会报错: 因为ListView高度边界无法确定了
/*      ListView.builder(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      }),*/

      //使用Expanded自动拉伸ListView组件大小
      Expanded(
        child: ListView.separated(
          itemCount: _words.length,
          itemBuilder: (context, index) {
            //如果到了表尾
            if (_words[index] == loadingTag) {
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

  void _retrieveData() {
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

