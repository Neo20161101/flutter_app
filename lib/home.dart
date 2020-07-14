import 'package:flutter/material.dart';
import './tabBar/tab1.dart';
import './tabBar/tab2.dart';
import './tabBar/tab3.dart';

class Home extends StatefulWidget {
  Home({Key key,active: false}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Home> {
//  final bool active;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    print(Home);
    switch (index){
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab1()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab2()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab3()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab3()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Tab3()));
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页'),
          backgroundColor:Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Tab2'),
          backgroundColor:Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Tab3'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Tab4'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          title: Text('我的'),
        ),
      ],
      currentIndex: _selectedIndex,
      type:BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}