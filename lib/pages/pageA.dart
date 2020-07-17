import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../util/store/store.dart'; // Import the store


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePage createState() => new _HomePage();
}


class _HomePage extends State<HomePage> {
  initState(){//willMount生命周期
    print(counter.value);
  }

  didChangeDependencies(){//didMount生命周期
    print('didMount生命周期4324324');
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageA'),
        ),
        body: new ListView(
          children: <Widget>[
            _titleSection(context)
          ],
        )
    );
  }
  Widget _titleSection (context) {
    return new Container(
      padding: const EdgeInsets.only(top: 32.0,bottom: 32.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(children: <Widget>[new Container(child:
          Observer(
            builder: (_) => Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),)],),
          new Column(children: <Widget>[new Container(child: new Text('2'),)],),
          new Column(children: <Widget>[new Container(child: new Text('3'),)],),
          new Column(children: <Widget>[new Container(child: new Text('4'),)],),
          new Column(children: <Widget>[new Container(child: new Text('5'),)],),
        ],
      ),
    );
  }

}
