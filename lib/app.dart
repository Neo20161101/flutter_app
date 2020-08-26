import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import './common/notFound/notFound.dart';
import 'tabBar/tab1.dart';
import 'tabBar/tab2.dart';
import 'tabBar/tab3.dart';
import 'tabBar/tab4.dart';
import 'tabBar/tab5.dart';

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  void initState() {
    main ();
    print('main初始化2');
  }
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
      routes: <String, WidgetBuilder>{
        '/index': (BuildContext context) => Tab1(),
        '/tab2': (BuildContext context) => Tab2(),
        '/tab3': (BuildContext context) => Tab3(),
        '/tab4': (BuildContext context) => Tab4(),
        '/tab5': (BuildContext context) => Tab5(),
        '/notFound': (BuildContext context) => NotFound(),
      },
    );
  }
  Future<void> main () async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    NotificationAppLaunchDetails notificationAppLaunchDetails;
    notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
// 初始化插件。app_icon需要作为可绘制资源添加到Android head项目中
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: false,//iOS 上的应用程序的稍后时间请求权限
        requestBadgePermission: false,//iOS 上的应用程序的稍后时间请求权限
        requestAlertPermission: false,//iOS 上的应用程序的稍后时间请求权限
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);//对于较旧的 iOS 版本，需要处理回调
    var initializationSettingsMacOS = MacOSInitializationSettings(
        requestAlertPermission: false,//MacOS 上的应用程序的稍后时间请求权限
        requestBadgePermission: false,//MacOS 上的应用程序的稍后时间请求权限
        requestSoundPermission: false//MacOS 上的应用程序的稍后时间请求权限
    );//mac版，针对移动端可取消
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
//        macOS: initializationSettingsMacOS//mac版，针对移动端可取消
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);//通知启动后，点击通知触发导航到另一个页面，并显示与通知关联的有效负载
  }
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  //对于较旧的 iOS 版本，需要处理回调
  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    didReceiveLocalNotificationSubject.add(ReceivedNotification(
        id: id, title: title, body: body, payload: payload));
  }

//通知启动后，点击通知触发导航到另一个页面，并显示与通知关联的有效负载
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  }
}



class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class SecondScreen extends StatefulWidget {
  SecondScreen(this.payload);

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen with payload: ${(_payload ?? '')}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
