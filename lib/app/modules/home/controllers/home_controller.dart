import 'package:get/get.dart';
import 'package:my_getx/store/store.dart';
import 'package:my_getx/api/http.dart';

final http = Http();

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final user = User().obs;
  final count = 0.obs;
  final String title = '首页';
  final data = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    http.getTest({'shopperId': '9356', 'machineId': '5117', 'orderType': '2', 'orderId': '108'}).then((res) => {
      data.value = res
    });
    super.onReady();
  }

  @override
  void onClose() {
    print('首页onClose');
    super.onClose();
  }

  void increment() => count.value++;
}
