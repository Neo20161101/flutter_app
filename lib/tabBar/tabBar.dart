import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key,this.active: 0}) : super(key: key);
  @override
  final int active;
  _TabState createState() => new _TabState();
}

class _TabState extends State<Home> {
  int _selectedIndex = 0;

  initState (){//willMount生命周期
    setState(() {
      _selectedIndex = widget.active;
    });
  }

  didChangeDependencies(){//didMount生命周期

  }

  dispose(){//离开销毁生命周期
    super.dispose();
  }
  void _onItemTapped(int index) {
    switch (index){
      case 0:
        Navigator.pushReplacementNamed(context,'/index');
        break;
      case 1:
        Navigator.pushReplacementNamed(context,'/tab2');
        break;
      case 2:
        Navigator.pushReplacementNamed(context,'/tab3');
        break;
      case 3:
        Navigator.pushReplacementNamed(context,'/tab4');
        break;
      case 4:
        Navigator.pushReplacementNamed(context,'/tab5');
        break;
      default:
        Navigator.pushNamed(context, '/notFound');
        break;
    }

//    setState(() {
//      _selectedIndex = index;
//    });
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