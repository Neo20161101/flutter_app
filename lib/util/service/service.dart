import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

Map header = {"loginSource": "IOS", 'content-type': 'application/json'};

class Service {
  fetch(context, url, body, method) async {
    print('准备请求');
    final httpClient = new HttpClient();
    HttpClientRequest request;
    try {
      if (method == 'get') {
        request = await httpClient.getUrl(Uri.parse(url));
        header.forEach((key, value) {
          request.headers.set(key, value);
        });
      } else {
        request = await httpClient.postUrl(Uri.parse(url));
        header.forEach((key, value) {
          request.headers.set(key, value);
        });
        // 添加请求体
        Map jsonMap = body ?? {};
//        Map<String, String> map1 = new Map();
//        map1["v"] = "1.0";
//        map1["month"] = "7";
        request.add(utf8.encode(json.encode(jsonMap)));
      }

      HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        String json = await response.transform(utf8.decoder).join();
//        String responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(json);
        this.showSnackBar(context, '请求数据成功！');
        httpClient.close();
        return data;
      } else {
        this.showSnackBar(context,
            'Error getting IP address:\nHttp status ${response.statusCode}');
      }
    } catch (exception) {
      this.showSnackBar(context, '服务器错误！');
    }
  }

  showSnackBar(context, text) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: new Text(text), backgroundColor: Colors.red));
  }
}
