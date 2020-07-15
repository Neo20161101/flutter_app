import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import './common/notFound/notFound.dart';
import 'tabBar/tab1.dart';
import 'tabBar/tab2.dart';
import 'tabBar/tab3.dart';
import 'tabBar/tab4.dart';
import 'tabBar/tab5.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      theme: new ThemeData(
        primaryColor: Colors.blue
      ),
      home: Tab1(),//默认首页
//      initialRoute: '/index',//默认跳转
      routes: {
        '/index': (BuildContext context) => Tab1(),//路由跳转建议：Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab1()))
        '/tab2': (BuildContext context) => Tab2(),//路由跳转建议：Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab2()))
        '/tab3': (BuildContext context) => Tab3(),//路由跳转建议：Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab3()))
        '/tab4': (BuildContext context) => Tab4(),//路由跳转建议：Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab4()))
        '/tab5': (BuildContext context) => Tab5(),//路由跳转建议：Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab5()))
        //以下自定义路由自由发挥
        '/notFound': (BuildContext context) => NotFound(),
      },
    );
  }
}
