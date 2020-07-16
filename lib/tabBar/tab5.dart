import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageE.dart';

class Tab5 extends StatefulWidget {
  Tab5({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab5> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: PageE(),//建议以组件形式引入
        bottomNavigationBar: Home(active: 4)
    );
  }
}