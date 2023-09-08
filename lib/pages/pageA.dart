import 'package:flutter/material.dart';
import '../util/service/http.dart';

final http = Http();


class HomePage extends StatefulWidget {
  const HomePage({ super.key });
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('显示通知 Flutter Demo'),
            backgroundColor: const Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Table(
                children: const [
                  TableRow(children: [Text('第一行')]),
                  TableRow(children: [Text('第二行')]),
                  TableRow(children: [Text('第三行')])
                ],
              ),
            ),
          )),
    );
  }
}
