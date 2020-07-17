import 'package:flutter/material.dart';

class PageD extends StatelessWidget {
  void _select(Choice choice) {}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageD'),
          leading: new IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            new IconButton(
              // action button
              icon: new Icon(Icons.format_shapes),
              onPressed: () {},
            ),
            new IconButton(
              // action button
              icon: new Icon(Icons.close),
              onPressed: () {},
            ),
            new PopupMenuButton<Choice>(
              // overflow menu
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return new PopupMenuItem<Choice>(
                    value: choice,
                    child: new Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: new ListView(
          children: <Widget>[_titleSection(context)],
        ));
  }

  Widget _titleSection(context) {
    return new Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('11'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('12'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('13'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('14'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('15'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];
