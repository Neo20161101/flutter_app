import 'package:flutter/material.dart';
import 'tabBar.dart';
import 'package:my_getx/app/modules/home/views/home_view.dart';

class Tab5 extends StatefulWidget {
  const Tab5({ super.key });
  @override
  State<Tab5> createState() => _TabState();
}

class _TabState extends State<Tab5> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: HomeView(),//建议以组件形式引入
        bottomNavigationBar: bottomTabBar(active: 4)
    );
  }
}