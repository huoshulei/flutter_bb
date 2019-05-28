import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/src/cupertino_localizations.dart';

import 'config.dart';
import 'net/http.dart';
import 'ui/main_page.dart';

void main() {
  initDio();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    isLogin = false;
//    isJoinGroup = false;
    return CupertinoApp(
      locale: const Locale('zh'),
      supportedLocales: [const Locale('zh', 'CN')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const FallbackCupertinoLocalisationsDelegate()
      ],
      title: '云海贝贝',
//      theme: ThemeData(
//          primaryColor: Color(0xFF0482e6),
//          backgroundColor: Color(0xfff7f7f7),
      theme: CupertinoThemeData(
          primaryColor: c_0482e6,
          barBackgroundColor: c_f7,
          textTheme: CupertinoTextThemeData(
              primaryColor: c_666,
              brightness: Brightness.light,
              textStyle: s_333_30,
              actionTextStyle: s_fff_26,
              navTitleTextStyle: s_fff_34_b,
              navActionTextStyle: s_fff_26,
              tabLabelTextStyle: s_22),
          scaffoldBackgroundColor: c_f7),
      home: MainPage(),
    );
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
