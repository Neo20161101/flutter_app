import 'package:get/get.dart';

import '../controllers/tab2_controller.dart';

class Tab2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Tab2Controller>(
      () => Tab2Controller(),
    );
  }
}
