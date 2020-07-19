import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
    main ();
  }

  Future<void> main () async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              print('go back');
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }


  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

  }

  void _handleGetTags() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  void _handleSendTags() {
    print("Sending tags");

  }

  void _handlePromptForPushPermission() {
    print("Prompting for Permission");

  }

  void _handleGetPermissionSubscriptionState() {
    print("Getting permissionSubscriptionState");

  }

  void _handleSetEmail() {
    if (_emailAddress == null) return;

    print("Setting email");


  }

  void _handleLogoutEmail() {
    print("Logging out of email");

  }

  void _handleConsent() {
    print("Setting consent to true");


    print("Setting state");
    this.setState(() {
      _enableConsentButton = false;
    });
  }

  void _handleSetLocationShared() {
    print("Setting location shared to true");

  }

  void _handleDeleteTag() {
    print("Deleting tag");

  }

  void _handleSetExternalUserId() {
    print("Setting external user ID");

  }

  void _handleRemoveExternalUserId() {


  }

  void _handleSendNotification() async {

  }

  void _handleSendSilentNotification() async {

  }

  oneSignalInAppMessagingTriggerExamples() async {

  }

  oneSignalOutcomeEventsExamples() async {

  }

  Future<void> outcomeAwaitExample() async {
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('OneSignal Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: new Table(
                children: [
                  new TableRow(children: [
                    new OneSignalButton(
                        "Get Tags", _handleGetTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Send Tags", _handleSendTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("推送权限提示",
                        _handlePromptForPushPermission, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "打印权限订阅状态",
                        _handleGetPermissionSubscriptionState,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "设置电子邮件", _handleSetEmail, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("注销的电子邮件", _handleLogoutEmail,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("提供GDPR同意", _handleConsent,
                        _enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("设置位置共享",
                        _handleSetLocationShared, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "删除 标签", _handleDeleteTag, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("发布通知",
                        _handleSendNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Post Silent Notification 沉默的通知后",
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
                    new OneSignalButton(
                        "设置外部用户ID", _handleSetExternalUserId, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "删除外部用户ID", _handleRemoveExternalUserId, !_enableConsentButton)
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
