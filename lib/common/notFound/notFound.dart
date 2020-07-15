import 'package:flutter/material.dart';
class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('404' ,style: new TextStyle(fontSize: 30.0),),
        ),
        body: new Center(
            child: new Image(image: AssetImage('assets/img/notfound/icon_404.png')),
        )
    );
  }


}