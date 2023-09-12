import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('404' ,style: TextStyle(fontSize: 30.0),),
        ),
        body: const Center(
          child: Image(image: AssetImage('assets/img/notfound/icon_404.png')),
        )
    );
  }


}