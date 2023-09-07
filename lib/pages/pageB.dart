import 'package:flutter/material.dart';

class AppBarBottomSample extends StatefulWidget {
  const AppBarBottomSample({ super.key });
  @override
  State<AppBarBottomSample> createState() => _AppBarBottomSampleState();
}

class _AppBarBottomSampleState extends State<AppBarBottomSample> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextPage(int delta) {

  }
  void _tabController() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Bottom Widget'),
        leading: IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () { _nextPage(-1); },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next choice',
            onPressed: () { _nextPage(1); },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.blue, Colors.pink],
              ),
            ),
            child: Text('sads'),
          ),
        ),
      ),
      body: Text('AppBar Bottom Widget'),
    );
  }
}