import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageB.dart';

class Tab2 extends StatefulWidget {
  const Tab2({ super.key });
  @override
  State<Tab2> createState() => _TabState();
}

class _TabState extends State<Tab2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarBottomSample(),//建议以组件形式引入
      bottomNavigationBar: Home(active: 1)
    );
  }
}