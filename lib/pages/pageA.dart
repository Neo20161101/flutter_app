import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:device_info/device_info.dart';
import '../util/service/http.dart';

final http = new Http();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

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

    _configureLocalTimeZone();// 设置默认的本地位置/时区.
    _requestPermissions();//ios mac 调用权限
  }

  @override
  void dispose() {
//    didReceiveLocalNotificationSubject.close();
//    selectNotificationSubject.close();
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

  // 设置默认的本地位置/时区.
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    // final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    String timezone;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone));
    } on PlatformException {
      timezone = 'Failed to get the timezone.';
    }
    print(timezone.toString());

  }

  //安排时间
  tz.TZDateTime _nextInstanceOfTenAM() {
    var now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  //保存图片路径
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    // import 'package:path_provider/path_provider.dart';//安卓系统路径
    // var directory = await getApplicationDocumentsDirectory();
    // var filePath = '${directory.path}/$fileName';
    var response = http.getImg(context, url);
    print(123456789);
    print(response);
    // var file = File(filePath);
    // await file.writeAsBytes(response.bodyBytes);
    // return filePath;
  }

  //显示通知
  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(subtitle: 'the subtitle');
    var macOSPlatformChannelSpecifics =
    MacOSNotificationDetails(subtitle: 'the subtitle');
    var platformChannelSpecifics = NotificationDetails(
        android:androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'title of notification with a subtitle',
        'body of notification with a subtitle',
        platformChannelSpecifics,
        payload: 'item x');
  }

  //仅显示title通知
  Future<void> _showNotificationWithNoBody() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(subtitle: 'the subtitle');
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', null, platformChannelSpecifics,
        payload: 'item x');
  }

  //显示通知与自定义的声音
  Future<void> _showNotificationCustomSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var macOSPlatformChannelSpecifics =
    MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'custom sound notification title',
        'custom sound notification body',
        platformChannelSpecifics);
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
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  //每分钟重复通知
  Future<void> _repeatNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        channelDescription: 'repeating description');
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  //安排每天上午10:00的通知
  Future<void> _scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAM(),
        NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  //安排每周上午10:00的通知
  Future<void> _scheduleWeeklyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'weekly scheduled notification title',
        'weekly scheduled notification body',
        _nextInstanceOfTenAM(),
        NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              channelDescription: 'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  //显示通知时没有声音
  Future<void> _showNotificationWithNoSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'silent channel id',
        'silent channel name',
        channelDescription: 'silent channel description',
        playSound: false,
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(presentSound: false);
    var macOSPlatformChannelSpecifics =
    MacOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '<b>silent</b> title',
        '<b>silent</b> body', platformChannelSpecifics);
  }

  //检查等待通知
  Future<void> _checkPendingNotificationRequests() async {
    var pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              '${pendingNotificationRequests.length} pending notification requests'),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

  //使用Android Uri声音显示通知
  Future<void> _showSoundUriNotification() async {
    // this calls a method over a platform channel implemented within the example app to return the Uri for the default
    // alarm sound and uses as the notification sound
    String alarmUri = await FlutterNativeTimezone.getLocalTimezone();
    final x = UriAndroidNotificationSound(alarmUri);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'uri channel id', 'uri channel name', channelDescription: 'uri channel description',
        sound: x,
        playSound: true,
        styleInformation: DefaultStyleInformation(true, true));
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'uri sound title', 'uri sound body', platformChannelSpecifics);
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

  //显示大图片通知
  Future<void> _showBigPictureNotification() async {
    // var largeIconPath = await _downloadAndSaveFile(
    //     'http://via.placeholder.com/48x48', 'largeIcon');
    // var bigPicturePath = await _downloadAndSaveFile(
    //     'http://via.placeholder.com/400x800', 'bigPicture');
    var bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap('http://via.placeholder.com/400x800'),
        largeIcon: FilePathAndroidBitmap('http://via.placeholder.com/48x48'),
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        channelDescription: 'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  //显示大图片通知，在展开时隐藏大图标
  Future<void> _showBigPictureNotificationHideExpandedLargeIcon() async {
    var largeIconPath = await _downloadAndSaveFile(
        'http://via.placeholder.com/48x48', 'largeIcon');
    var bigPicturePath = await _downloadAndSaveFile(
        'http://via.placeholder.com/400x800', 'bigPicture');
    var bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        channelDescription: 'big text channel description',
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  Future<void> _showFullScreenNotification() async {
    await showDialog(
        context: context,
        builder: (_)=>AlertDialog(
          title: Text('Turn off your screen'),
          content: Text(
              'to see the full-screen intent in 5 seconds, press OK and TURN OFF your screen'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () async {
                await flutterLocalNotificationsPlugin.zonedSchedule(
                    0,
                    'scheduled title',
                    'scheduled body',
                    tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
                    NotificationDetails(
                        android: AndroidNotificationDetails(
                            'full screen channel id',
                            'full screen channel name',
                            channelDescription: 'full screen channel description',
                            priority: Priority.high,
                            importance: Importance.high,
                            fullScreenIntent: true)),
                    androidAllowWhileIdle: true,
                    uiLocalNotificationDateInterpretation:
                    UILocalNotificationDateInterpretation.absoluteTime);

                Navigator.pop(context);
              },
            )
          ],
        ));
  }























  Future<void> _showNotificationMediaStyle() async {
    var largeIconPath = await _downloadAndSaveFile(
        'http://via.placeholder.com/128x128/00FF00/000000', 'largeIcon');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'notification body', platformChannelSpecifics);
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

  Future<void> _showInboxNotification() async {
    var lines = List<String>();
    lines.add('line <b>1</b>');
    lines.add('line <i>2</i>');
    var inboxStyleInformation = InboxStyleInformation(lines,
        htmlFormatLines: true,
        contentTitle: 'overridden <b>inbox</b> context title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'inbox channel id', 'inboxchannel name', channelDescription: 'inbox channel description',
        styleInformation: inboxStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'inbox title', 'inbox body', platformChannelSpecifics);
  }

  Future<void> _showMessagingNotification() async {
    // use a platform channel to resolve an Android drawable resource to a URI.
    // This is NOT part of the notifications plugin. Calls made over this channel is handled by the app
    // String imageUri = await platform.invokeMethod('drawableToUri', 'food');
    String imageUri = '';
    var messages = List<Message>();
    // First two person objects will use icons that part of the Android app's drawable resources
    var me = Person(
      name: 'Me',
      key: '1',
      uri: 'tel:1234567890',
      icon: DrawableResourceAndroidIcon('me'),
    );
    var coworker = Person(
      name: 'Coworker',
      key: '2',
      uri: 'tel:9876543210',
      icon: FlutterBitmapAssetAndroidIcon('icons/coworker.png'),
    );
    // download the icon that would be use for the lunch bot person
    var largeIconPath = await _downloadAndSaveFile(
        'http://via.placeholder.com/48x48', 'largeIcon');
    // this person object will use an icon that was downloaded
    var lunchBot = Person(
      name: 'Lunch bot',
      key: 'bot',
      bot: true,
      icon: BitmapFilePathAndroidIcon(largeIconPath),
    );
    messages.add(Message('Hi', DateTime.now(), null));
    messages.add(Message(
        'What\'s up?', DateTime.now().add(Duration(minutes: 5)), coworker));
    messages.add(Message(
        'Lunch?', DateTime.now().add(Duration(minutes: 10)), null,
        dataMimeType: 'image/png', dataUri: imageUri));
    messages.add(Message('What kind of food would you prefer?',
        DateTime.now().add(Duration(minutes: 10)), lunchBot));
    var messagingStyle = MessagingStyleInformation(me,
        groupConversation: true,
        conversationTitle: 'Team lunch',
        htmlFormatContent: true,
        htmlFormatTitle: true,
        messages: messages);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'message channel id',
        'message channel name',
        channelDescription: 'message channel description',
        category: 'msg',
        styleInformation: messagingStyle);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'message title', 'message body', platformChannelSpecifics);

    // wait 10 seconds and add another message to simulate another response
    await Future.delayed(Duration(seconds: 10), () async {
      messages.add(
          Message('Thai', DateTime.now().add(Duration(minutes: 11)), null));
      await flutterLocalNotificationsPlugin.show(
          0, 'message title', 'message body', platformChannelSpecifics);
    });
  }

  Future<void> _showGroupedNotifications() async {
    var groupKey = 'com.android.example.WORK_EMAIL';
    var groupChannelId = 'grouped channel id';
    var groupChannelName = 'grouped channel name';
    var groupChannelDescription = 'grouped channel description';
    // example based on https://developer.android.com/training/notify-user/group.html
    var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
        groupChannelId, groupChannelName, channelDescription: groupChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey);
    var firstNotificationPlatformSpecifics =
    NotificationDetails(android: firstNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
        'You will not believe...', firstNotificationPlatformSpecifics);
    var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
        groupChannelId, groupChannelName, channelDescription: groupChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey);
    var secondNotificationPlatformSpecifics =
    NotificationDetails(android: secondNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(
        2,
        'Jeff Chang',
        'Please join us to celebrate the...',
        secondNotificationPlatformSpecifics);

    // Create the summary notification to support older devices that pre-date Android 7.0 (API level 24).
    // Recommended to create this regardless as the behaviour may vary as mentioned in
    // https://developer.android.com/training/notify-user/group
    var lines = List<String>();
    lines.add('Alex Faarborg  Check this out');
    lines.add('Jeff Chang    Launch Party');
    var inboxStyleInformation = InboxStyleInformation(lines,
        contentTitle: '2 messages', summaryText: 'janedoe@example.com');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        groupChannelId, groupChannelName, channelDescription: groupChannelDescription,
        styleInformation: inboxStyleInformation,
        groupKey: groupKey,
        setAsGroupSummary: true);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        3, 'Attention', 'Two messages', platformChannelSpecifics);
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




  Future<void> _showNotificationWithSubtitle() async {
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(subtitle: 'the subtitle');
    var macOSPlatformChannelSpecifics =
    MacOSNotificationDetails(subtitle: 'the subtitle');
    var platformChannelSpecifics = NotificationDetails(
        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'title of notification with a subtitle',
        'body of notification with a subtitle',
        platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _showNotificationWithIconBadge() async {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(badgeNumber: 1);
    var macOSPlatformChannelSpecifics =
    MacOSNotificationDetails(badgeNumber: 1);
    var platformChannelSpecifics = NotificationDetails(
        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
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

  Future<void> _showNotificationWithAttachment() async {
    var bigPicturePath = await _downloadAndSaveFile(
        'http://via.placeholder.com/600x200', 'bigPicture.jpg');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(bigPicturePath)]);
    var macOSPlatformChannelSpecifics = MacOSNotificationDetails(
        attachments: [MacOSNotificationAttachment(bigPicturePath)]);
    var notificationDetails = NotificationDetails(
        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'notification with attachment title',
        'notification with attachment body',
        notificationDetails);
  }

  Future<void> _createNotificationChannel() async {
    var androidNotificationChannel = AndroidNotificationChannel(
      'your channel id 2',
      'your channel name 2',
      description: 'your channel description 2',
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                'Channel with name \"${androidNotificationChannel.name}\" created'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _deleteNotificationChannel() async {
    const channelId = 'your channel id 2';
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelId);

    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Channel with id \"$channelId\" deleted'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _getActiveNotifications() async {
    Widget activeNotificationsDialogContent =
    await _getActiveNotificationsDialogContent();
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: activeNotificationsDialogContent,
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<Widget> _getActiveNotificationsDialogContent() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (!(androidInfo.version.sdkInt >= 23)) {
      return Text(
        '"getActiveNotifications" is available only for Android 6.0 or newer',
      );
    }

    try {
      List<ActiveNotification> activeNotifications =
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Active Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(color: Colors.black),
          if (activeNotifications.isEmpty) Text('No active notifications'),
          if (activeNotifications.isNotEmpty)
            for (var activeNotification in activeNotifications)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'id: ${activeNotification.id}\n'
                        'channelId: ${activeNotification.channelId}\n'
                        'title: ${activeNotification.title}\n'
                        'body: ${activeNotification.body}',
                  ),
                  Divider(color: Colors.black),
                ],
              ),
        ],
      );
    } on PlatformException catch (error) {
      return Text(
        'Error calling "getActiveNotifications"\n'
            'code: ${error.code}\n'
            'message: ${error.message}',
      );
    }
  }



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
                        "显示通知", _showNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "仅显示title通知", _showNotificationWithNoBody, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示通知与自定义的声音",
                        _showNotificationCustomSound, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "安排通知",
                        _zonedScheduleNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("每分钟重复通知", _repeatNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "安排每天上午10:00的通知", _scheduleDailyTenAMNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "安排每周上午10:00的通知", _scheduleWeeklyTenAMNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示通知时没有声音", _showNotificationWithNoSound,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "检查等待通知", _checkPendingNotificationRequests, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("取消通知",
                        _cancelNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("取消所有通知",
                        _cancelAllNotifications, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    Text(
                      '针对android的例子',
                      style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.center
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示普通通知与有效负载和更新通道描述", _showNotificationWithUpdatedChannelDescription,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("在每个锁屏上显示普通通知", _showPublicNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示通知自定义振动模式，LED和图标", _showNotificationCustomVibrationIconLed,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("使用Android Uri声音显示通知", _showSoundUriNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示3秒后超时的通知", _showTimeoutNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("展示的通知", _showInsistentNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示大图片通知", _showBigPictureNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("显示大图片通知，在展开时隐藏大图标", _showBigPictureNotificationHideExpandedLargeIcon,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show media notification", _showNotificationMediaStyle,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show big text notification", _showBigTextNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show inbox notification", _showInboxNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show messaging notification", _showMessagingNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show grouped notifications", _showGroupedNotifications,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show ongoing notification", _showOngoingNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show notification with no badge, alert only once", _showNotificationWithNoBadge,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show progress notification - updates every second", _showProgressNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show indeterminate progress notification", _showIndeterminateProgressNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show notification without timestamp", _showNotificationWithoutTimestamp,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show full-screen notification", _showFullScreenNotification,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Create notification channel", _createNotificationChannel,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Delete notification channel", _deleteNotificationChannel,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Get active notifications", _getActiveNotifications,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    Text(
                      'iOS and macOS-specific examples',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show notification with subtitle", _showNotificationWithSubtitle,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show notification with icon badge", _showNotificationWithIconBadge,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Show notification with attachment", _showNotificationWithAttachment,
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
