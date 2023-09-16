import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:my_getx/components/loading/loading.dart';


class Service {
  get code => null;
  final header = {'content-type': 'application/json; charset=utf-8'};
  final localhost = 'api.spacexdata.com';
  // 解决 证书过期问题
  http.Client client() {
    var ioClient = HttpClient();
    ioClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(ioClient);
  }
  fetch(url, body, method) async {
    Loading.show(Get.overlayContext);//加载loading
    var response;
    try {
      switch (method) {
        case 'get':
          response = await client().get(Uri.https(localhost, url,body),headers: header);
          break;
        default:
          response = await client().post(Uri.https(localhost, url), body: body,headers: header );
          break;
      }
      Loading.hide(Get.overlayContext);//取消loading
      if (response.statusCode == 200 && response.statusCode <= 304) {
        return jsonDecode(response.body);
      }
      Get.snackbar('服务器错误！', '${response.statusCode}');
      return {code:response.statusCode};

      if (method == 'get') {
        var url1 = Uri.https(localhost, url,body);
        var response = await http.get(url1,headers: header);
        Loading.hide(Get.overlayContext);//取消loading
        print(response.statusCode);
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        Get.snackbar('服务器错误！', '${response.statusCode}');
        return {code:response.statusCode};
      } else {
        var url1 = Uri.https(localhost, url);
        var response = await http.post(url1, body: body,headers: header );
        Loading.hide(Get.overlayContext);//取消loading
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        Get.snackbar('服务器错误！', '${response.statusCode}');
        return {code:response.statusCode};
      }
    } catch (error){
      Loading.hide(Get.overlayContext);//取消loading
      Get.snackbar('服务器错误！', '$error');
      return {code:error};
    }

  }

  showSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.red));
  }
}

