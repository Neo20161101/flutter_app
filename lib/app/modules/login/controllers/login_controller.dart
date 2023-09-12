import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_getx/api/http.dart';
import 'package:my_getx/store/store.dart';

final http = Http();

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final count = 0.obs;
  final String title = '登录';
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    print('登录onInit');
    super.onInit();
  }

  @override
  void onReady() {
    print('登录onReady');
    super.onReady();
  }

  @override
  void onClose() {
    print('登录onClose');
    super.onClose();
  }



  void onLogin() {
    http.getTest({'shopperId': '9356', 'machineId': '5117', 'orderType': '2', 'orderId': '108'}).then((res) => {
    storage.write('token', 'João'),
    Get.offNamed("/home")
    });
  }

  void increment() => count.value++;
}
