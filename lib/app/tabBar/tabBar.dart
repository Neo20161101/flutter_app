import 'package:flutter/material.dart';
import 'package:get/get.dart';

class bottomTabBar extends StatefulWidget {
  const bottomTabBar({ super.key,this.active = 0 });
  final int active;
  @override
  State<bottomTabBar> createState() => _TabState();
}

class _TabState extends State<bottomTabBar> {
  int _selectedIndex = 0;

  @override
  void initState (){//willMount生命周期
    setState(() {
      _selectedIndex = widget.active;
    });
    super.initState();
  }

  @override
  void didChangeDependencies(){  //didMount生命周期
    super.didChangeDependencies();


  }

  @override
  void dispose(){//离开销毁生命周期
    super.dispose();
  }
  void _onItemTapped(int index) {
    switch (index){
      case 0:
        Get.offNamed("/tab1");
        break;
      case 1:
        Get.offNamed("/tab2");
        break;
      case 2:
        Get.offNamed("/tab3");
        break;
      case 3:
        Get.offNamed("/tab4");
        break;
      case 4:
        Get.offNamed("/tab5");
        break;
      default:
        Get.offNamed("/not-found");
        break;
    }
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