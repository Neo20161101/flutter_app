import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tabBar.dart';
import '../pages/pageA.dart';

class Tab1 extends StatefulWidget {
  const Tab1({ super.key });
  @override
  State<Tab1> createState() => _TabState();
}

class _TabState extends State<Tab1> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _token;

  @protected
  @mustCallSuper
  void initState(){//willMount生命周期
    super.initState();
    getToken();
  }

  void didChangeDependencies(){//didMount生命周期
    print('didMount生命周期');
  }

  void dispose(){//离开销毁生命周期
    print('清除状态,离开路由');
    super.dispose();
  }

  void deactive() { //其它组件Navigator跳转到这的函数,子组件可能不会触发
    print('条件苛刻：其它组件Navigator跳转到这的函数,子组件可能不会触发');
  }

  getToken() async {
    final SharedPreferences prefs = await _prefs;
    _token = prefs.getString('token');
    print('_token,${_token}');
    if (_token==null){
      Navigator.pushReplacementNamed(context,'/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),//建议以组件形式引入,tabBar左边起第一个页面
      bottomNavigationBar: Home(active: 0)
    );
  }
}