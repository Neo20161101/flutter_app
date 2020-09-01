import 'package:flutter/material.dart';
import 'tabBar.dart';
import '../pages/pageA.dart';

class Tab1 extends StatefulWidget {
  Tab1({Key key}) : super(key: key);
  @override
  _TabState createState() => new _TabState();
}

class _TabState extends State<Tab1> {
  initState(){//willMount生命周期
    print('initState生命周期');

  }

  didChangeDependencies(){//didMount生命周期
    print('didMount生命周期');
  }

  dispose(){//离开销毁生命周期
    print('清除状态,离开路由');
    super.dispose();
  }

  deactive() { //其它组件Navigator跳转到这的函数,子组件可能不会触发
    print('条件苛刻：其它组件Navigator跳转到这的函数,子组件可能不会触发');
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: HomePage(),//建议以组件形式引入,tabBar左边起第一个页面
      bottomNavigationBar: Home(active: 0)
    );
  }
}