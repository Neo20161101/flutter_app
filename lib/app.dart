import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './common/notFound/notFound.dart';
import 'tabBar/tab1.dart';
import 'tabBar/tab2.dart';
import 'tabBar/tab3.dart';
import 'tabBar/tab4.dart';
import 'tabBar/tab5.dart';
import 'pages/user/login.dart';

class MyApp extends StatefulWidget {
  const MyApp({ super.key });
  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('main初始化2');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: const Tab1(),//默认首页
//      initialRoute: '/index',//默认跳转
      routes: <String, WidgetBuilder>{
        '/index': (BuildContext context) => const Tab1(),
        '/tab2': (BuildContext context) => const Tab2(),
        '/tab3': (BuildContext context) => const Tab3(),
        '/tab4': (BuildContext context) => const Tab4(),
        '/tab5': (BuildContext context) => const Tab5(),
        '/notFound': (BuildContext context) => NotFound(),
        '/login': (BuildContext context) => Login(),
      },
    );
  }

}
