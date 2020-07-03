import 'package:flutter/cupertino.dart';

//According to the key change, the component used to restart the application or widget
class RestartWidget extends StatefulWidget {
  final Widget childWidget;

  RestartWidget({Key key, @required this.childWidget})
      : assert(childWidget != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state = context.findAncestorStateOfType<_RestartWidgetState>();
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.childWidget,
    );
  }
}
