import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './util/store/store.dart'; // Import the store
import 'app.dart';
void main() => runApp(
  MultiProvider(
    providers: [ // 这里存放多个自定义的状态
      Provider<stateStore>(create: (_) => stateStore())
    ],
    child: MyApp(),
  ),
);