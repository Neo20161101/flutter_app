import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});


  static void show(context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
        child: const CupertinoActivityIndicator(
          radius: 30.0,
          animating: true,
        ),
      ),
    );
  }

  static void hide(context) {
    Navigator.pop(context, 'Cancel');
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      type: MaterialType.transparency,
      child: Text('Loading'),
    );
  }
}
