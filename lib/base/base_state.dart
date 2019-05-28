import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bb/ui/common/login_page.dart';
import 'package:toast/toast.dart';

import '../config.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Api api;

  @override
  void initState() {
    api = Api(this);
    super.initState();
  }

  toast(String msg) {
    Toast.show(msg, context, duration: 1);
  }

  refreshLogin() {
    Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LoginPage()))
        .then((v) {
      refreshData();
      setState(() {
        isGroup = v == true;
      });
    });
  }

  refreshData() {}

  refreshGroup(bool b) {
    if (b != isGroup) {
      setState(() {
        isGroup = b;
      });
    }
  }

  @override
  void dispose() {
    api.cancel();
    api = null;
    super.dispose();
  }
}
