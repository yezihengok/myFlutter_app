import 'package:flutter/material.dart';



class SecondScreen extends StatelessWidget {


  final msg;
  const SecondScreen({Key key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return new Scaffold(

      appBar: new AppBar(
        title: new Text("第二个页面"),


      ),
      body: new Center(

        child: new RaisedButton(
          onPressed: () {
            //Navigator.pop(context);
            // Navigator.pop(context,"不需要");

            msg!=null?Navigator.pop(context,"不需要"):Navigator.pop(context);

          },
          child: new Text('传过来的值:$msg'),
        ),
      ),
    );
  }
}