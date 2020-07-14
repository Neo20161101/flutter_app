import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageA'),
        ),
        body: new ListView(
          children: [
            titleSection
          ],
        )
    );
  }

  Widget titleSection = new Container(
    padding: const EdgeInsets.only(top: 32.0,bottom: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Column(children: <Widget>[new Container(child: new Text('1'),)],),
        new Column(children: <Widget>[new Container(child: new Text('2'),)],),
        new Column(children: <Widget>[new Container(child: new Text('3'),)],),
        new Column(children: <Widget>[new Container(child: new Text('4'),)],),
        new Column(children: <Widget>[new Container(child: new Text('5'),)],),
      ],
    ),
  );
}
