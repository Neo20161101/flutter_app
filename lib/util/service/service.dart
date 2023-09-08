import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../common/cupertinoActivity/Loading.dart';

var header = {"loginSource": "IOS", 'content-type': 'application/json; charset=utf-8','com':'123456789'};
const localhost = 'api.spacexdata.com';

class Service {
  get code => null;

  fetch(context, url, body, method) async {
    Loading.show(context);//加载loading
    if (method == 'get') {
      var url1 = Uri.https(localhost, url);
      var response = await http.get(url1,headers: header);
      Loading.dismiss(context);//取消loading
      if (response.statusCode == 200) {
        return response.body;
      }
      showSnackBar(context, '服务器错误！');
      return {code:500};
    } else {
      var url1 = Uri.https(localhost, url);
      var response = await http.post(url1, body: body,headers:header);
      Loading.dismiss(context);//取消loading
      if (response.statusCode == 200) {
        return response.body;
      }
      showSnackBar(context, '服务器错误！');
      return {code:500};
    }
  }

  showSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.red));
  }
}
