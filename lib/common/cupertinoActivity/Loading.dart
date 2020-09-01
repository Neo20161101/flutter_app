import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
        child: CupertinoActivityIndicator(
          radius: 30.0,
          animating: true,
        ),
      ),
    );
  }

  static void dismiss(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: Text('Loading'),
    );
  }
}
