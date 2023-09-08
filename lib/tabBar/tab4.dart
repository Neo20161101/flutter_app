import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageD.dart';

class Tab4 extends StatefulWidget {
  const Tab4({ super.key });
  @override
  State<Tab4> createState() => _TabState();
}

class _TabState extends State<Tab4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageD(),//建议以组件形式引入
        bottomNavigationBar: bottomTabBar(active: 3)
    );
  }
}