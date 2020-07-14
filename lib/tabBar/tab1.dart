import 'package:flutter/material.dart';
import '../home.dart';
import '../pages/pageA.dart';

class Tab1 extends StatefulWidget {
  Tab1({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: HomePage(),
      bottomNavigationBar: Home(active: true)
    );
  }
}