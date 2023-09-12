import 'package:flutter/material.dart';
import 'tabBar.dart';
import 'package:my_getx/app/modules/notFound/views/not_found_view.dart';

class Tab2 extends StatefulWidget {
  const Tab2({ super.key });
  @override
  State<Tab2> createState() => _TabState();
}

class _TabState extends State<Tab2> {

  @override
  void initState(){//willMount生命周期
    debugPrint('willMount生命周期');
    super.initState();
  }

  @override
  void didChangeDependencies(){//didMount生命周期
    debugPrint('didMount生命周期');
    super.didChangeDependencies();
  }

  @override
  void dispose(){//离开销毁生命周期
    debugPrint('tab2离开销毁');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotFoundView(),//建议以组件形式引入
      bottomNavigationBar: bottomTabBar(active: 1)
    );
  }
}