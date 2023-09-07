import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../util/service/http.dart';

final http = Http();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

class HomePage extends StatefulWidget {
  const HomePage({ super.key });
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _debugLabelString = "";
  var _emailAddress;
  var _externalUserId;
  bool _enableConsentButton = false;
  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;



  @override
  void initState() {
    super.initState();
    _requestPermissions();//ios mac 调用权限
  }

  @override
  void dispose() {
    super.dispose();
  }

  //ios mac 调用权限
  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



  //安排通知
  Future<void> _zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', channelDescription: 'your channel description')),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  //取消通知
  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  //取消所有通知
  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  //显示普通通知与有效负载和更新通道描述
  Future<void> _showNotificationWithUpdatedChannelDescription() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your updated channel description',
        importance: Importance.max,
        priority: Priority.high,
        channelAction: AndroidNotificationChannelAction.update);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'updated notification channel',
        'check settings to see updated channel description',
        platformChannelSpecifics,
        payload: 'item x');
  }

  //在每个锁屏上显示普通通知
  Future<void> _showPublicNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        visibility: NotificationVisibility.public);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'public notification title',
        'public notification body', platformChannelSpecifics,
        payload: 'item x');
  }

  //显示通知自定义振动模式，LED和图标
  Future<void> _showNotificationCustomVibrationIconLed() async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'other custom channel id',
        'other custom channel name',
        channelDescription: 'other custom channel description',
        icon: 'app_icon',//小图
        largeIcon: DrawableResourceAndroidBitmap('app_icon'),//大图
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'title of notification with custom vibration pattern, LED and icon',
        'body of notification with custom vibration pattern, LED and icon',
        platformChannelSpecifics);
  }

  //显示3秒后超时的通知
  Future<void> _showTimeoutNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'silent channel id',
        'silent channel name',
        channelDescription: 'silent channel description',
        timeoutAfter: 3000,
        styleInformation: DefaultStyleInformation(true, true));
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'timeout notification',
        'Times out after 3 seconds', platformChannelSpecifics);
  }

  //展示的通知
  Future<void> _showInsistentNotification() async {
    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
    var insistentFlag = 4;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList([insistentFlag]));
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'insistent title', 'insistent body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showBigTextNotification() async {
    var bigTextStyleInformation = BigTextStyleInformation(
        'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        htmlFormatBigText: true,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        channelDescription: 'big text channel description',
        styleInformation: bigTextStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  Future<void> _showOngoingNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        autoCancel: false);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
        'ongoing notification body', platformChannelSpecifics);
  }

  Future<void> _showNotificationWithNoBadge() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'no badge channel', 'no badge name', channelDescription: 'no badge description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'no badge title', 'no badge body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showProgressNotification() async {
    var maxProgress = 5;
    for (var i = 0; i <= maxProgress; i++) {
      await Future.delayed(Duration(seconds: 1), () async {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'progress channel',
            'progress channel',
            channelDescription: 'progress channel description',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0,
            'progress notification title',
            'progress notification body',
            platformChannelSpecifics,
            payload: 'item x');
      });
    }
  }

  Future<void> _showIndeterminateProgressNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'indeterminate progress channel',
        'indeterminate progress channel',
        channelDescription: 'indeterminate progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        indeterminate: true);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'indeterminate progress notification title',
        'indeterminate progress notification body',
        platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showNotificationWithoutTimestamp() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showNotificationWithCustomTimestamp() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('显示通知 Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Table(
                children: [
                  TableRow(children: [
                    OneSignalButton(
                        title:"安排通知",
                        onPressed:_zonedScheduleNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"取消通知",
                        onPressed:_cancelNotification, enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"取消所有通知",
                        onPressed:_cancelAllNotifications, enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      '针对android的例子',
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.center
                    )
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"显示普通通知与有效负载和更新通道描述", onPressed:_showNotificationWithUpdatedChannelDescription,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"在每个锁屏上显示普通通知", onPressed:_showPublicNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"显示通知自定义振动模式，LED和图标", onPressed:_showNotificationCustomVibrationIconLed,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"显示3秒后超时的通知", onPressed:_showTimeoutNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"展示的通知", onPressed:_showInsistentNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show big text notification", onPressed:_showBigTextNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show ongoing notification", onPressed:_showOngoingNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show notification with no badge, alert only once", onPressed:_showNotificationWithNoBadge,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show progress notification - updates every second", onPressed:_showProgressNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show indeterminate progress notification", onPressed:_showIndeterminateProgressNotification,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    OneSignalButton(title:"Show notification without timestamp", onPressed:_showNotificationWithoutTimestamp,
                        enabled:!_enableConsentButton)
                  ]),
                  TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      'iOS and macOS-specific examples',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      child: Text(_debugLabelString),
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


class OneSignalButton extends StatefulWidget {
  const OneSignalButton({
    super.key,
    this.title = '',
    required this.onPressed,
    this.enabled = false
});
  final String title;
  final Function() onPressed;
  final bool enabled;

  @override
  State<OneSignalButton> createState() => _OneSignalButtonState();
}

class _OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(8.0),
            ),
            child: new Text(widget.title),
            onPressed: widget.enabled ? widget.onPressed : null,
          )
        ]),
        TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}
