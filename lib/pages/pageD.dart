

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/store/store.dart'; // Import the store

class PageD extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PageD> {
  var _stateStore;
  @override
  void initState() {
    super.initState();
    // print(_stateStore.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _stateStore = Provider.of<stateStore>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('tab4,${_stateStore?.value}'),
        ),
        body: new Text('safdasfd'),
      ),
    );
  }

}