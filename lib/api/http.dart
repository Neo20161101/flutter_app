import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:my_getx/service/service.dart';
import 'package:my_getx/store/store.dart';

final service = Service();
final user = User().obs;
GetStorage storage = GetStorage();
void setHearder() {
  final token = storage.read('token');
  print('setHearder,${token}');
      if (token != ''){
        // service.header['token'] = user.token;
      }else{
        // 防刷新处理
      }
    }

class Http {
  Future<dynamic> getTest(body) async {
    setHearder();
    return await service.fetch('/v3/capsules', body, 'get');
  }

  Future<dynamic> getImg(body) async {
    setHearder();
    return await service.fetch('/v3/capsules', body, 'get');
  }
}
