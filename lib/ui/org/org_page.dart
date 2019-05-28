import '../../config.dart';

class OrgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrgState();
  }
}

class _OrgState extends BaseState<OrgPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text("org"));
  }
}
