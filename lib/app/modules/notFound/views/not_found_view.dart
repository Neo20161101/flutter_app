import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/not_found_controller.dart';

class NotFoundView extends GetView<NotFoundController> {
  const NotFoundView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('404' ,style: TextStyle(fontSize: 30.0),),
        ),
        body: const Center(
          child: Image(image: AssetImage('assets/img/notFound/icon_404.png')),
        )
    );
  }
}
