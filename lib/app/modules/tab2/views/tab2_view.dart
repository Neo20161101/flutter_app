import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/tab2_controller.dart';

class Tab2View extends GetView<Tab2Controller> {
  const Tab2View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab2View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Tab2View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
class FocusExample extends StatefulWidget {
  const FocusExample({super.key});

  @override
  State<FocusExample> createState() => _FocusExampleState();
}

class _FocusExampleState extends State<FocusExample> {
  dynamic _color = 'Colors.white';

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {

      setState(() {
        _color = event.physicalKey;
      });
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return FocusScope(
      debugLabel: 'Scope',
      autofocus: true,
      child: DefaultTextStyle(
        style: textTheme.headlineMedium!,
        child: Focus(
          autofocus: true,
          canRequestFocus: true,
          onKey: _handleKeyPress,
          debugLabel: 'Button',
          child: Text('$_color'),
        ),
      ),
    );
  }
}
