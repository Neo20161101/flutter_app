import 'package:flutter/material.dart';
import '../util/service/http.dart';

final http = new Http();

class PageE extends StatelessWidget {
  const PageE({ Key key, this.id }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {

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
          new Column(children: <Widget>[
            new Container(
              child: new RaisedButton(
                onPressed: (){
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                          content: new Text('sad'),
                          backgroundColor:Colors.red
                      )
                  );
                },
                child: new Text('点击消息框'),
              ),
            ),
          ],),
          new Column(children: <Widget>[
            new Container(
              child: new RaisedButton(
                onPressed: () async{
                  final result = await http.getTest(context,{'shopperId': 9356,'machineId':5117,'orderType':2,'orderId':108});
                  print(result);
                },
                child: new Text('点击请求'),
              ),
            ),
          ],),
        ],
      ),
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('个人中心'),
        ),
        body: new ListView(
          children: <Widget>[
            titleSection,
            contentSection
          ],
        )
    );
  }
}

