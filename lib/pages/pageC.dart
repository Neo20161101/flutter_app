import 'package:flutter/material.dart';
class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageC'),
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
        new Column(children: <Widget>[new Container(child: new Text('6'),)],),
        new Column(children: <Widget>[new Container(child: new Text('7'),)],),
        new Column(children: <Widget>[new Container(child: new Text('8'),)],),
        new Column(children: <Widget>[new Container(child: new Text('9'),)],),
        new Column(children: <Widget>[new Container(child: new Text('10'),)],),
      ],
    ),
  );
}
