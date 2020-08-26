import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  String _debugLabelString = "";
  String _emailAddress;
  String _externalUserId;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;



  @override
  void initState() {
    super.initState();
    _configureLocalTimeZone();
  }

  @override
  void dispose() {
//    didReceiveLocalNotificationSubject.close();
//    selectNotificationSubject.close();
    super.dispose();
  }

  // 设置默认的本地位置/时区.
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    String timezone;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } on PlatformException {
      timezone = 'Failed to get the timezone.';
    }
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  void _handleGetTags() async { //显示通知
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  void _handleSendTags() async { //安排通知
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  void _handlePromptForPushPermission() async { //定期显示具有指定间隔的通知
    // Show a notification every minute with the first appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics);
  }

  void _handleGetPermissionSubscriptionState() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${time.hour}:${time.minute}:${time.second}',
        time,
        platformChannelSpecifics);
  }

  void _handleSetEmail() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately ${time.hour}:${time.minute}:${time.second}',
        Day.monday,
        time,
        platformChannelSpecifics);
  }

  void _handleLogoutEmail() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  void _handleConsent() async {
    String groupKey = 'com.android.example.WORK_EMAIL';
    String groupChannelId = 'grouped channel id';
    String groupChannelName = 'grouped channel name';
    String groupChannelDescription = 'grouped channel description';
// example based on https://developer.android.com/training/notify-user/group.html
    AndroidNotificationDetails firstNotificationAndroidSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: groupKey);
    NotificationDetails firstNotificationPlatformSpecifics =
        NotificationDetails(android: firstNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
        'You will not believe...', firstNotificationPlatformSpecifics);
    AndroidNotificationDetails secondNotificationAndroidSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: groupKey);
    NotificationDetails secondNotificationPlatformSpecifics =
        NotificationDetails(android: secondNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(
        2,
        'Jeff Chang',
        'Please join us to celebrate the...',
        secondNotificationPlatformSpecifics);

// create the summary notification required for older devices that pre-date Android 7.0 (API level 24)
    List<String> lines = List<String>();
    lines.add('Alex Faarborg  Check this out');
    lines.add('Jeff Chang    Launch Party');
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
        contentTitle: '2 new messages', summaryText: 'janedoe@example.com');
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            styleInformation: inboxStyleInformation,
            groupKey: groupKey,
            setAsGroupSummary: true);
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        3, 'Attention', 'Two new messages', platformChannelSpecifics);
  }

  void _handleSetLocationShared() async {
    // cancel the notification with id value of zero
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void _handleDeleteTag() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void _handleSetExternalUserId() async {
    print("Setting external user ID");
  }

  void _handleRemoveExternalUserId() async {}

  void _handleSendNotification() async {
    var notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  void _handleSendSilentNotification() async {}

  oneSignalInAppMessagingTriggerExamples() async {}

  oneSignalOutcomeEventsExamples() async {}

  Future<void> outcomeAwaitExample() async {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('显示通知 Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: new Table(
                children: [
                  new TableRow(children: [
                    new OneSignalButton(
                        "显示通知", _handleGetTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "安排通知", _handleSendTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("定期显示具有指定间隔的通知",
                        _handlePromptForPushPermission, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "在特定时间显示每日通知",
                        _handleGetPermissionSubscriptionState,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示特定日期和时间上的每周通知", _handleSetEmail,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "检索挂起的通知请求", _handleLogoutEmail, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "[仅安卓]分组通知", _handleConsent, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("取消/删除通知", _handleSetLocationShared,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "取消/删除所有通知", _handleDeleteTag, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("获取应用程序是否通过此插件创建的通知启动的详细信息",
                        _handleSendNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("[仅 ios]重新安装后显示定期通知",
                        _handleSendSilentNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "外部用户ID",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 212, 86, 83),
                          )),
                      onChanged: (text) {
                        this.setState(() {
                          _externalUserId = text == "" ? null : text;
                        });
                      },
                    )
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("设置外部用户ID", _handleSetExternalUserId,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("删除外部用户ID", _handleRemoveExternalUserId,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new Container(
                      child: new Text(_debugLabelString),
                      alignment: Alignment.center,
                    )
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}

typedef void OnButtonPressed();

class OneSignalButton extends StatefulWidget {
  final String title;
  final OnButtonPressed onPressed;
  final bool enabled;

  OneSignalButton(this.title, this.onPressed, this.enabled);

  State<StatefulWidget> createState() => new OneSignalButtonState();
}

class OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Table(
      children: [
        new TableRow(children: [
          new FlatButton(
            disabledColor: Color.fromARGB(180, 212, 86, 83),
            disabledTextColor: Colors.white,
            color: Color.fromARGB(255, 212, 86, 83),
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: new Text(widget.title),
            onPressed: widget.enabled ? widget.onPressed : null,
          )
        ]),
        new TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}
