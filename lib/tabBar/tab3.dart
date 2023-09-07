import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageC.dart';

class Tab3 extends StatefulWidget {
  const Tab3({ super.key });
  @override
  State<Tab3> createState() => _TabState();
}

class _TabState extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageC(),//建议以组件形式引入
      bottomNavigationBar: Home(active: 2)
    );
  }
}