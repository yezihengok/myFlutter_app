import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '标题',
    home: new MyStackContnet(),
  ));
}

//Stack层叠布局类似于Android中的Frame布局 Flutter中使用Stack和Positioned来实现绝对定位，Stack允许子widget堆叠，而Positioned可以给子widget定位
class MyStackContnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('层叠布局Stack--类似于FrameLayout'),
      ),
     // body: _buildContnet(),
      body: _buildContnet2(),
    );
  }

///  Stack属性：
/*  Stack({
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.overflow = Overflow.clip,
    List<Widget> children = const <Widget>[],
  })
  alignment：此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子widget。所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴
  ，top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位。

  textDirection：和Row、Wrap的textDirection功能一样，都用于决定alignment对齐的参考系即：textDirection的值为TextDirection.ltr，则
  alignment的start代表左，end代表右；textDirection的值为TextDirection.rtl，则alignment的start代表右，end代表左。

  fit：此参数用于决定没有定位的子widget如何去适应Stack的大小。StackFit.loose表示使用子widget的大小，StackFit.expand表示扩伸到Stack的大小。

  overflow：此属性决定如何显示超出Stack显示空间的子widget，值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。*/

/*  const Positioned({
    Key key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    @required Widget child,
  })*/
//  left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离.width和height用于指定定位元素的宽度和高度，
//  注意，此处的width、height 和其它地方的意义稍微有点区别，此处用于配合left、top 、right、 bottom来定位widget，
// 举个例子，在水平方向时，你只能指定left、right、width三个属性中的两个，如指定left和width后，right会自动算出(left+width)，
// 如果同时指定三个属性则会报错，垂直方向同理

  Widget _buildContnet() {
    //通过ConstrainedBox来确保Stack占满屏幕
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[

          //)没有指定定位，并且alignment值为Alignment.center，所以，它会居中显示
          Container(
              child: Text("中间显示", style: TextStyle(color: Colors.white)),
              color: Colors.lightBlue),

          //)只指定了水平方向的定位(left)，所以属于部分定位，即垂直方向上没有定位，
          // 那么它在垂直方向对齐方式则会按照alignment指定的对齐方式对齐，即垂直方向居中
          Positioned(
            left: 20,
            child: Text("距离左边20"),
          ),
          Positioned(
            top: 20,
            child: Text("距离顶部20"),
          ),
          Positioned(
            bottom: 20,
            child: Text("距底部20"),
          ),
          Positioned(
            right: 20,
            child: Text("距离右边20"),
          )

        ],
      ),
    );
  }


  Widget _buildContnet2() {
    //通过ConstrainedBox来确保Stack占满屏幕
    return ConstrainedBox(

    //可以看到，由于第二个子widget没有定位，所以fit属性会对它起作用，就会占满Stack。
      //Stack层叠显示 所以效果就是：文本2 3  显示了   文本1 被文本2控件 遮住

      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment:Alignment.center ,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Positioned(
            left: 18.0,
            child: Text("文本1"),
          ),
          Container(child: Text("文本2",style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),
          Positioned(
            top: 18.0,
            child: Text("文本3  "),
          )
        ],
      ),
    );
  }


}
