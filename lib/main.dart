import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:my_getx/store/store.dart';

// StoreController user = Get.put(StoreController(), permanent: true);
void main() async {
  // Get.create(()=>StoreController());
  // Get.lazyPut(() => StoreController(), fenix: true);
  await GetStorage.init();
  runApp(
    GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        routingCallback: (routing) {}),
  );
}
