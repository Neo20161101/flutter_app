
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  final colorCodes = [1, 2];
  final  _stateStore = StateStore();


  @override
  void initState() {
    super.initState();
    print(_stateStore.value);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)).then((e) {
      getTest(context);
    });
  }

  void getTest(context) async {
    final result = await http.getTest(context,
        {'shopperId': 9356, 'machineId': 5117, 'orderType': 2, 'orderId': 108});
    print(result);
    // setState(() {
    //   data = result;
    // });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('个人中心'),
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
              Observer(
                builder: (_) => Text(
                  '${_stateStore.value}',
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          const Column(
            children: <Widget>[
              Text('17')
            ],
          ),
          const Column(
            children: <Widget>[
              Text('18')
            ],
          ),
          const Column(
            children: <Widget>[
              Text('19')
            ],
          ),
          const Column(
            children: <Widget>[
              Text('20')
            ],
          ),
        ],
      ),
    );
  }

  Widget _contentSection(context) {

    return Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              CupertinoButton(
                onPressed: () {
                  print(_stateStore.greeting.value);
                },
                child: const Text('点击消息'),
              ),
            ],
          ),
          Column(children: <Widget>[
            CupertinoButton(
              onPressed: () => {
                _stateStore.greeting.value = '已被更改',
                _stateStore.increment()
    },
              child: const Text('moBx状态变化'),
            )
          ]),
          Column(
            children: <Widget>[
              CupertinoButton(
                onPressed: () {
                  getTest(context);
                },
                child: const Text('点击请求'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listViewSection(data) {
    return Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
//    height: 300,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 0,
        itemBuilder: (context, index) {
          return ListTile(
              leading: const Icon(Icons.settings),
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
