import 'package:flutter/material.dart';
import '../home.dart';
import '../pages/pageC.dart';

class Tab3 extends StatefulWidget {
  Tab3({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageC(),
      bottomNavigationBar: Home()
    );
  }
}