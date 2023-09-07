import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ super.key,this.active = 0 });
  final int active;
  @override
  State<Home> createState() => _TabState();
}

class _TabState extends State<Home> {
  int _selectedIndex = 0;

  void initState (){//willMount生命周期
    setState(() {
      _selectedIndex = widget.active;
    });
  }

  void didChangeDependencies(){//didMount生命周期

  }

  void dispose(){//离开销毁生命周期
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
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首页',
          backgroundColor:Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Tab2',
          backgroundColor:Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Tab3',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Tab4',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: '我的',
        ),
      ],
      currentIndex: _selectedIndex,
      type:BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}