import '../../config.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MineState();
  }
}

class _MineState extends BaseState<MinePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Text("mine"));
  }
}
