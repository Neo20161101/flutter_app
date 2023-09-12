import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'tabBar.dart';
import 'package:my_getx/app/modules/home/views/home_view.dart';

class Tab1 extends StatefulWidget {
  const Tab1({ super.key });
  @override
  State<Tab1> createState() => _TabState();
}

class _TabState extends State<Tab1> {

  GetStorage storage = GetStorage();

  @override
  void initState(){//willMount生命周期
    super.initState();
  }

  @override
  void didChangeDependencies(){//didMount生命周期
    debugPrint('didMount生命周期');
    getToken();
    super.didChangeDependencies();
  }

  @override
  void dispose(){//离开销毁生命周期
    debugPrint('tab1,离开路由');
    super.dispose();
  }

getToken() async {
  final token = storage.read('token');
  if (token == '') {
    print('跳转登录页,${token}');
    Get.offAllNamed('/login');
    return;
  }

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),//建议以组件形式引入,tabBar左边起第一个页面
      bottomNavigationBar: bottomTabBar(active: 0)
    );
  }
}