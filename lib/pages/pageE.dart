
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../util/service/http.dart';
import '../util/store/store.dart'; // Import the store

final http = Http();

class PageE extends StatefulWidget {
  const PageE({ super.key,this.id = 0 });
  final int id;
  @override
  State<PageE> createState() => _PageE();
}

class _PageE extends State<PageE> {
  List data = [];
  final List<int> colorCodes = <int>[1, 2];
  var  _stateStore;


  void initState() {
    super.initState();
    // print(_stateStore.toString());
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2)).then((e) {
      getTest(context);
    });
  }

  void getTest(context) async {
    final result = await http.getTest(context,
        {'shopperId': 9356, 'machineId': 5117, 'orderType': 2, 'orderId': 108});
    print(result);
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context){  // 我们的store
    _stateStore = Provider.of<stateStore>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('个人中心'),
        ),
        body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                _titleSection(context),
                _contentSection(context),
                _listViewSection(data)
              ],
            )));
  }

  Widget _titleSection(context) {
    return Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Observer(
                  builder: (_) => Text(
                    '${_stateStore?.value}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('17'),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('18'),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('19'),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('20'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _contentSection(context) {

    return Observer(
      builder: (_)=>Container(
        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: CupertinoButton(
                    onPressed: () {
//                  Locale myLocale = Localizations.localeOf(context);//获取设备语言进行国际化
                      print(_stateStore);
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //     content: new Text('sad'), backgroundColor: Colors.red));
                    },
                    child: Text('点击消息框'),
                  ),
                ),
              ],
            ),
            Column(children: <Widget>[
              Container(
                child: CupertinoButton(
                  onPressed: () {
                    _stateStore.increment();
                  },
                  child: Text('moBx状态变化'),
                ),
              )
            ]),
            Column(
              children: <Widget>[
                Container(
                  child: CupertinoButton(
                    onPressed: () {
                      getTest(context);
                    },
                    child: Text('点击请求'),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget _listViewSection(data) {
    return Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
//    height: 300,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 0,
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
