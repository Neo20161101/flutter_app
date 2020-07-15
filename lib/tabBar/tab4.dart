import 'package:flutter/material.dart';
import '../home.dart';
import '../pages/pageD.dart';

class Tab4 extends StatefulWidget {
  Tab4({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab4> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: PageD(),//建议以组件形式引入
        bottomNavigationBar: Home(active: 3)
    );
  }
}