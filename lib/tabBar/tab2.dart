import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageB.dart';

class Tab2 extends StatefulWidget {
  Tab2({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab2> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AppBarBottomSample(),//建议以组件形式引入
      bottomNavigationBar: Home(active: 1)
    );
  }
}