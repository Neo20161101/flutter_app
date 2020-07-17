import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../util/service/http.dart';
import '../util/store/store.dart'; // Import the store

final http = new Http();

class PageE extends StatelessWidget {
  const PageE({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('个人中心'),
        ),
        body: new ListView(
          children: <Widget>[
            _titleSection(context),
            _contentSection(context),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('哈哈哈 哈哈哈 哈哈'),
                subtitle: Text('嘿嘿嘿 嘿嘿 '),
                selected: true,
                enabled: false),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('哈哈哈 哈哈 '),
              subtitle: Text('嘿嘿嘿 嘿嘿 '),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.yellow,
              ),
              title: Text('哈哈哈 哈哈哈'),
              subtitle: Text('嘿嘿嘿 嘿嘿嘿'),
            ),
          ],
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
                child: Observer(
                  builder: (_) => Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('17'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('18'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('19'),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                child: new Text('20'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _contentSection(context) {
    return new Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                child: new RaisedButton(
                  onPressed: () {
//                  Locale myLocale = Localizations.localeOf(context);//获取设备语言进行国际化
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: new Text('sad'), backgroundColor: Colors.red));
                  },
                  child: new Text('点击消息框'),
                ),
              ),
            ],
          ),
          new Column(children: <Widget>[
            new Container(
              child: new RaisedButton(
                onPressed: () {
                  counter.increment();
                },
                child: new Text('moBx状态变化'),
              ),
            )
          ]),
          new Column(
            children: <Widget>[
              new Container(
                child: new RaisedButton(
                  onPressed: () async {
                    final result = await http.getTest(context, {
                      'shopperId': 9356,
                      'machineId': 5117,
                      'orderType': 2,
                      'orderId': 108
                    });
                    print(result);
                  },
                  child: new Text('点击请求'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const data = [
  {'name': 1},
  {'name': 2}
];

Widget _listViewSection(context) {
  return new Container(
    padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
    child: new Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Column(children: <Widget>[]),
      ],
    ),
  );
}
