import '../../config.dart';

class ScorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreState();
  }
}

class _ScoreState extends BaseState<ScorePage> {
  String _score;
  String _num;

  @override
  void initState() {
    super.initState();
    api.getScore().then((v) {
      _score = v.fraction.toString();
      _num = v.runEquipmentCount.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCupertinoNavigationBar('设备评分', previousPageTitle: '消息'),
      body: _score == null
          ? Text('')
          : ListView(
              padding: EdgeInsets.only(top: m128),
              children: <Widget>[
                Container(
                  width: m450,
                  height: m450,
                  alignment: Alignment.center,
                  child: Container(
                    width: m320,
                    height: m320,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(_score,
                            style: s_ff0000_96_b, textAlign: TextAlign.center),
                        Text('分', style: s_ff0000_48_b),
                      ],
                    ),
                    decoration:
                        BoxDecoration(color: c_2ed184, shape: BoxShape.circle),
                  ),
                  decoration:
                      BoxDecoration(color: c_00ff00, shape: BoxShape.circle),
                ),
                Padding(
                  padding: EdgeInsets.only(top: m120),
                  child: Text("当前$_num台设备运行良好",
                      style: s_333_30, textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.only(left: m60, top: m80, right: m60),
                  child: MaterialButton(
                      height: m100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(m80))),
                      splashColor: c_afff,
                      child: Text('详情', style: s_fff_30),
                      color: c_0482e6,
                      onPressed: _detail),
                )
              ],
            ),
    );
  }

  _detail() {
    // TODO: 2019/5/24 0024 列表页
  }
}
