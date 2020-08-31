import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../util/service/http.dart';
import '../util/store/store.dart'; // Import the store
final http = new Http();
class PageE extends StatefulWidget {
  const PageE({Key key, this.id}) : super(key: key);
  final int id;
  @override
  _PageE createState() => _PageE();
}
class _PageE extends State<PageE> {
  List data = [];
  final List<int> colorCodes = <int>[1,2];
  final _stateStore = stateStore();

  void initState () {
    super.initState();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2)).then((e){
      getTest (context);
    });
  }

  void getTest (context) async{
    final result = await http.getTest(context, {
      'shopperId': 9356,
      'machineId': 5117,
      'orderType': 2,
      'orderId': 108
    });
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('个人中心'),
        ),
        body: new RefreshIndicator(
            onRefresh: _onRefresh,
            child:  new ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                _titleSection(context),
                _contentSection(),
                _listViewSection(data)
              ],
            )
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
                    '${_stateStore.value}',
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

  Widget _contentSection() {
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
                    CircularProgressIndicator();
                    // Scaffold.of(context).showSnackBar(SnackBar(
                    //     content: new Text('sad'), backgroundColor: Colors.red));
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
                  _stateStore.increment();
                },
                child: new Text('moBx状态变化'),
              ),
            )
          ]),
          new Column(
            children: <Widget>[
              new Container(
                child: new RaisedButton(
                  onPressed: (){
                    getTest(context);
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
  Widget _listViewSection(data) {
    return new Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
//    height: 300,
      child: new ListView.separated(
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Icon(Icons.settings),
              title: Text('${data[index]['capsule_serial']}'),
              subtitle: Text('${data[index]['details']}'),
              selected: true,
              enabled: false);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}


//List<Widget> getData() {
//  var tempList = data.map((value) {
//    return ListTile(
//      leading: Image.network(value["imageUrl"]),
//      title: Text(value["title"]),
//      subtitle: Text(value["author"]),
//    );
//  });
//  return tempList.toList();
//}

