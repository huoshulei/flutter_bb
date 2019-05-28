import '../../config.dart';

///appBar
CupertinoNavigationBar buildCupertinoNavigationBar(String title,
    {BuildContext context, String tag, String previousPageTitle}) {
  return CupertinoNavigationBar(
//    padding: EdgeInsetsDirectional.only(end: m30),
//    leading: context == null
//        ? null
//        : IconButton(
//      alignment: Alignment.centerLeft,
//      icon: Icon(Icons.arrow_back_ios, color: color_dd888888, size: m50),
//      onPressed: () {
//        Navigator.pop(context);
//      },
//    ),
//    previousPageTitle: previousPageTitle,
    middle: Text(
      title,
      style: s_fff_34_b,
    ),
////        elevation: 5,

    backgroundColor: c_0482e6,
    actionsForegroundColor: c_d888,
//    transitionBetweenRoutes: false,
//    heroTag: tag ?? title,
  );
}

CupertinoNavigationBar buildCupertinoNavigationBarNor(String title,
    {BuildContext context,
    String tag,
    String previousPageTitle,
    Color backgroundColor}) {
  return CupertinoNavigationBar(
//    padding: EdgeInsetsDirectional.only(end: m30),
//    leading: context == null
//        ? null
//        : IconButton(
//      alignment: Alignment.centerLeft,
//      icon: Icon(Icons.arrow_back_ios, color: color_dd888888, size: m50),
//      onPressed: () {
//        Navigator.pop(context);
//      },
//    ),
    previousPageTitle: previousPageTitle,
    middle: Text(
      title,
      style: s_fff_36_b,
    ),
////        elevation: 5,

    backgroundColor: backgroundColor ?? c_0482e6,
    actionsForegroundColor: c_d888,
    transitionBetweenRoutes: false,
    heroTag: tag ?? title,
    border: Border(),
  );
}
