import 'package:flutter/material.dart';
class PageE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('个人中心'),
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
      new Column(children: <Widget>[new Container(child: new Text('16'),)],),
      new Column(children: <Widget>[new Container(child: new Text('17'),)],),
      new Column(children: <Widget>[new Container(child: new Text('18'),)],),
      new Column(children: <Widget>[new Container(child: new Text('19'),)],),
      new Column(children: <Widget>[new Container(child: new Text('20'),)],),
    ],
  ),
);

Widget contentSection = new Container(
  padding: const EdgeInsets.only(top: 32.0,bottom: 32.0),
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new Column(children: <Widget>[new Container(child: new Text('16'),)],),
      new Column(children: <Widget>[new Container(child: new Text('17'),)],),
      new Column(children: <Widget>[new Container(child: new Text('18'),)],),
      new Column(children: <Widget>[new Container(child: new Text('19'),)],),
      new Column(children: <Widget>[new Container(child: new Text('20'),)],),
    ],
  ),
);