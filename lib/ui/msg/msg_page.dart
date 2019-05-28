import '../../bean/message_entity.dart';
import '../equip/score_page.dart';
import '../work/work_page.dart';

import '../../config.dart';

class MsgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MsgState();
  }
}

class _MsgState extends BaseState<MsgPage> {
  var _data = <MessageEntity>[];

  var _score;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MsgPage oldWidget) {
    super.didUpdateWidget(oldWidget);
//    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNavigationBar(),
      body: RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.only(top: m10, bottom: m15),
            itemBuilder: _itemBuilder,
            itemCount: _data.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: m1, indent: m30);
            },
          ),
          onRefresh: _refresh),
    );
  }

  Future<void> _refresh() => api.getMessages().then((v) {
        _data.clear();
        _data.addAll(v);
        return api.getScore().then((v) {
          setState(() {
            _score = v.fraction;
          });
        });
      });

  Widget _itemBuilder(context, index) => ListTile(
        title: Text(_data[index].pushType, style: s_333_30),
        subtitle: Text(_data[index].pushContent, style: s_999_28),
        contentPadding: EdgeInsets.only(left: m30, right: m20),
        leading: Container(
          width: m110,
          padding: EdgeInsets.all(m5),
          alignment: Alignment.center,
          child: Text(_data[index].pushType,
              textAlign: TextAlign.center, style: s_333_30),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: c_0482e6, width: m6)),
        ),
        trailing: ConstrainedBox(
          constraints: BoxConstraints.expand(width: m60),
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Icon(CupertinoIcons.forward, color: c_ccc, size: m44),
              _data[index].messageCount > 0
                  ? Positioned(
                      left: 0,
                      top: m5,
                      child: Container(
                        width: m30,
                        height: m30,
                        alignment: Alignment.center,
                        child: Text('${_data[index].messageCount}',
                            textAlign: TextAlign.center, style: s_fff_22),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ))
                  : Text('')
            ],
          ),
        ),
        dense: true,
        onTap: () {
          _click(index);
        },
      );

  CupertinoNavigationBar _buildNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text('消息'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoButton(
              child: Text(_score == null ? '' : '$_score分', style: s_fff_26),
              padding: EdgeInsets.only(right: m30),
              minSize: 0,
              onPressed: _score == null ? null : _onTapScore),
          CupertinoButton(
              child: Image.asset("icons/ic_qr_code.png", width: m40),
              padding: EdgeInsets.all(0),
              minSize: 0,
              onPressed: _qrCode)
        ],
      ),
      backgroundColor: c_0482e6,
//      transitionBetweenRoutes: false,
//      heroTag: 'msg',
    );
  }

  void _qrCode() {

    //todo 扫描二维码
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => WorkPage()));
  }

  void _onTapScore() {
    //todo  评分页
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ScorePage()));
  }

  void _click(index) {
    // TODO: 2019/5/23 0023 item 页
  }
}
