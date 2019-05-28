//import 'dart:io';

import 'package:flutter/services.dart';
//import 'package:flutter_bb/net/http.dart';

import '../config.dart';

import 'common/login_page.dart';
import 'msg/msg_page.dart';
import 'bb/bb_page.dart';
import 'work/work_page.dart';
import 'org/org_page.dart';
import 'mine/mine_page.dart';
//import '../utils/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends BaseState<MainPage> {
  @override
  void initState() {
    super.initState();
    isLogin.then((v) {
      if (v) {
        isJoinGroup.then((v) {
          if (v != isGroup) {
            setState(() {
              isGroup = v;
            });
          }
        });
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LoginPage()))
            .then((v) {
          setState(() {
            isGroup = v == true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
        child: CupertinoTabScaffold(
          tabBuilder: (context, index) {
            return index == 0
                ? MsgPage()
                : index == 1
                    ? WorkPage()
                    : index == 2
                        ? BBPage()
                        : index == 3 ? OrgPage() : MinePage();
          },
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.conversation_bubble),
                  title: Text('消息')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), title: Text('工作')),
              BottomNavigationBarItem(
                  icon: Image.asset('icons/tab_beibei.png', width: 25),
                  activeIcon:
                      Image.asset('icons/tab_beibei_select.png', width: 25),
                  title: Text('贝贝')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.group), title: Text('通讯录')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), title: Text('我的'))
            ],
          ),
        ),
        onWillPop: _onWillPop);
  }

  ///退出APP
  Future<bool> _onWillPop() async {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: Text('温馨提示'),
                content: Text('确定退出APP?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        Navigator.pop(context);
//                        exit(0);
                        await SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: Text('确定')),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消'))
                ]));
    return false;
  }
}
