

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../util/store/store.dart'; // Import the store

class PageD extends StatefulWidget {
  const PageD({ super.key });
  @override
  State<PageD> createState() => _HomePageState();
}

class _HomePageState extends State<PageD> {
  final _stateStore = StateStore();
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) => Text(
              'tab4,${_stateStore.value}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        body: const Text('safdasfd'),
      ),
    );
  }

}