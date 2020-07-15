import 'package:flutter/material.dart';
class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageD'),
        ),
        body: new ListView(
          children: <Widget>[
            titleSection
          ],
        )
    );
  }

}
Widget titleSection = new Container(
  padding: const EdgeInsets.only(top: 32.0,bottom: 32.0),
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new Column(children: <Widget>[new Container(child: new Text('11'),)],),
      new Column(children: <Widget>[new Container(child: new Text('12'),)],),
      new Column(children: <Widget>[new Container(child: new Text('13'),)],),
      new Column(children: <Widget>[new Container(child: new Text('14'),)],),
      new Column(children: <Widget>[new Container(child: new Text('15'),)],),
    ],
  ),
);