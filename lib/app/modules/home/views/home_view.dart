import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(()=>ListView.builder(
          itemCount: controller.data.length,
          prototypeItem: const ListTile(
            title: Text('未知型号'),
          ),
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(controller.data[index]['capsule_serial'] ?? '未知型号'),
                subtitle: Text(controller.data[index]['details'] ?? '未知型号')
            );
          },
        )
        ),
      ),
    );
  }
}
