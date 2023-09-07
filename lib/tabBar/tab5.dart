import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageE.dart';

class Tab5 extends StatefulWidget {
  const Tab5({ super.key });
  @override
  State<Tab5> createState() => _TabState();
}

class _TabState extends State<Tab5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageE(),//建议以组件形式引入
        bottomNavigationBar: Home(active: 4)
    );
  }
}