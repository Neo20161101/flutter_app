

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _stateStore;

  onLogin(context) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token','这是token');
    Navigator.pushReplacementNamed(context,'/index');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '请输入账户',
                    labelText: '账户',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '请输入账户';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '请输入密码',
                    labelText: '密码',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        onLogin(context);
                      }

                    },
                    child: const Text('登录'),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }

}