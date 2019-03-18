import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //随机生成字符串单词的一个 引用包

//Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
//
//Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
//
//一个 StatefulWidget类。
//一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.

//=====这个 RandomWords=随机生成单词的 Text控件
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final word = new WordPair.random();
    //
    return new Text(word.asPascalCase);
  }
}

//=====创建一个无限滚动ListView
class RandomWordsList extends StatefulWidget {
  @override
  createState() => new RandomWordsStateList();
}

class RandomWordsStateList extends State<RandomWordsList> {

  //在Flutter中，导航器管理应用程序的路由栈(页面栈)。将路由推入push到导航器的栈中，将会显示更新为该路由页面。
  // 从导航器的栈中弹出（pop）路由，将显示返回到前一个路由。

  /**
   * 点击列表图标的时候跳转新路由（在Flutter中称页面为路由 ）
   */
  void _pushSaved() {

//    当用户点击导航栏中的列表图标时，建立一个路由并将其推入到导航管理器栈中。此操作会切换页面以显示新路由。
//    新页面的内容在在MaterialPageRoute的builder属性中构建，builder是一个匿名函数。
//    添加Navigator.push调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(

      //添加MaterialPageRoute及其builder。 现在，添加生成ListTile行的代码。ListTile的divideTiles()方法在每个ListTile之间添加1像素的分割线。 该 divided 变量持有最终的列表项
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _save.map((pair) {
              return new ListTile(
                  title: new Text(pair.asLowerCase, style: _smallFont,),
              );
            },
          );
          final divided = ListTile.divideTiles(context: context, tiles: tiles,).toList();

          //builder返回一个Scaffold，其中包含名为“收藏的Suggestions”的新路由的应用栏。
          // 新路由的body由包含ListTiles行的ListView组成; 每行之间通过一个分隔线分隔。
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('收藏的Suggestions '),
            ),
            body: new ListView(children: divided),
          );

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return _buildSuggestions();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('标题'),
        //某些widget属性需要单个widget（child），而其它一些属性，如action，需要一组widgets(children），用方括号[]表示。
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //向RandomWordsState类中添加一个_suggestions列表以保存建议的单词对。 该变量以下划线（_）开头，在Dart语言中使用下划线前缀标识符，会强制其变成私有的。
  var _suggestions = <WordPair>[];
  final _bigFont = const TextStyle(fontSize: 19);
  final _smallFont = const TextStyle(fontSize: 15,color: Colors.deepOrange);
  final _save = Set<WordPair>(); //（收藏）的set集合
  var _cont=10;


  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(_cont));
            print('随机又添加了$_cont条数据~~~'); // 打印到控制台。
          }

          //对于每一个单词对，_buildSuggestions函数都会调用一次_buildRow。 这个函数在ListTile中显示每个新词
          return _buildRow(_suggestions[index]);
        });
  }

  //创建row 即item
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _save.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigFont,
      ),
      // 添加一个心形 ❤️ 图标到 ListTiles以启用收藏功能
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.pinkAccent : null,
      ),

      //点击item的时候 不存在则 添加，存在 移除
      onTap: () {
        setState(() {
          //在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，对UI的更新
          if (alreadySaved) {
            _save.remove(pair);
          } else {
            _save.add(pair);
          }
        });
      },
    );
  }
}
