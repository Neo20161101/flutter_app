import 'package:get/get.dart';
import 'package:my_getx/store/store.dart';
import 'package:my_getx/api/http.dart';

final http = Http();

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final user = User().obs;
  final count = 0.obs;
  final data = [].obs;

  @override
  void onInit() {
    print('首页onInit');
    super.onInit();
  }

  @override
  void onReady() {
    print('首页onReady');
    var arr = [];
    getToken();
    http.getTest({'shopperId': '9356', 'machineId': '5117', 'orderType': '2', 'orderId': '108'}).then((res) => {
      for(var i = 0; i< 100000;i++) {
        arr.add({'capsule_serial':'$i','details':'details$i'})
      },
      data.value = arr
    });
    super.onReady();
  }

  @override
  void onClose() {
    print('首页onClose');
    super.onClose();
  }

  void getToken() {
    final token = storage.read('token');
    if (token == null) {
      print('跳转登录页,${token}');
      Get.offAllNamed('/login');
      return;
    }

  }

  void increment() => count.value++;
}
