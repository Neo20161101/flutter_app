import 'package:flutter/material.dart';
import 'tabBar.dart';
import 'package:my_getx/app/modules/home/views/home_view.dart';

class Tab3 extends StatefulWidget {
  const Tab3({ super.key });
  @override
  State<Tab3> createState() => _TabState();
}

class _TabState extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),//建议以组件形式引入
      bottomNavigationBar: bottomTabBar(active: 2)
    );
  }
}