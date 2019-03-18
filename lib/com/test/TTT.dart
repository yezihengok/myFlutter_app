import 'package:myflutter_app/com/test/TTT.dart';


 main() {
  //Final 和 Const
/*使用过程中从来不会被修改的变量， 可以使用 final 或 const, 而不是 var 或者其他类型， Final 变量的值只能被设置一次；
Const 变量在编译时就已经固定 (Const 变量 是隐式 Final 的类型.) 最高级 final 变量或类变量在第一次使用时被初始化。*/
  final name = 'Bob'; // Without a type annotation
  final String nickname = 'Bobby';

   const bar = 1000000; //
   const double atm = 1.01 * bar;
//String
//Dart 字符串是一组 UTF-16 单元序列。 字符串通过单引号或者双引号创建。
  var s1 = 'okoko';
  var s2 = "as well.";

  test();
}



void test(){
  //字符串可以通过 ${expression} 的方式内嵌表达式。 如果表达式是一个标识符，则 {} 可以省略
  var time =2;
  print('今天上了$time次厕所');

  var list = [1, 2, 3];
  var constantList = const [1, 2, 3];//表示编译时常亮
//     constantList[1] = 1; // 取消注释会引起错误。(编译不会出错，运行时报错)

  //在 Dart 中 Set 是一个元素唯一且无需的集合。 Dart 为 Set 提供了 Set 字面量和 Set 类型。
  var halogens = {'aaa', 'bbb', 'ccc', 'ddd'};//Dart 推断 halogens 类型为 Set<String> 。

  //要创建一个空集，使用前面带有类型参数的 {}
  var names = <String>{};
// Set<String> names = {}; // 这样也是可以的。
// var names = {}; // 这样会创建一个 Map ，而不是 Set 。

  //使用 Map 字面量的简单例子：
  var gifts = {
  // Key:    Value
  'first': 'a11',
  'second': 'a22',
  'third': 'a33'
  };
//Map 对象也可以使用 Map 构造函数创建：
  var gift = Map();
  gifts['first'] = 'a';
  gifts['second'] = 'b';
  gifts['third'] = 'c';//添加key（third） -value（c）


  isNoble(number) {
    return number!=null;
  }
  //如果函数中只有一句表达式，可简写：=> expr 语法是 { return expr; } 的简写。 => 符号 有时也被称为 箭头 语法。
  bool isNobles(String number)=> number!=null;

  say("aa","ok");

  enableFlags(bold:true);
}


//可选参数 参数放到 [] 中来标记参数是可选的：
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

//在定义方法的时候，可以使用 = 来定义可选参数的默认值
void enableFlags({bool bold = false, bool hidden = false}) {//.bold.}


  //list 或 map 可以作为默认值传递。 如下 并分别指定参数 list 和 gifts 的默认值。
  void doit(
      {List<int> list = const [1, 2, 3],
        Map<String, String> gifts = const {
          'first': 'paper',
          'second': 'cotton',
          'third': 'leather'
        }})
  {
    print('list:  $list');
    print('gifts: $gifts');
  }



  ///多数函数是有名字的， 比如 main()  也可以创建没有名字的函数，这种函数被称为 匿名函数，
  // 有时候也被称为 lambda 或者 closure 。 匿名函数可以被复制到一个变量中
  //下面例子 定义了一个包含一个无类型参数 item 的匿名函数
  var list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });

  //函数只有一条语句，=> 可简写:
  list.forEach(
          (item) => print('${list.indexOf(item)}: $item') );

//condition ? expr1 : expr2
/*  如果条件为 true, 执行 expr1 (并返回它的值)： 否则, 执行并返回 expr2 的值。
  expr1 ?? expr2
  如果 expr1 是 non-null， 返回 expr1 的值； 否则, 执行并返回 expr2 的值。*/


//

  String playerName(String name) => name ?? 'Guest';
//上面写法等于下面效果
  String playerNames(String name) {
    if (name != null) {
      return name;
    } else {
      return 'Guest';
    }
  }

  var collection = [0, 1, 2];
  for (var x in collection) {
    print(x); // 0 1 2
  }

  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  // ignore: expected_token
  callbacks.forEach((c) => c());


