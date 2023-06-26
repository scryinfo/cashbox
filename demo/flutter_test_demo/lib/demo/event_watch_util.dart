import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventWatchUtil extends StatefulWidget {
  @override
  _EventWatchUtilState createState() => _EventWatchUtilState();
}

class _EventWatchUtilState extends State<EventWatchUtil> {
  static const EventChannel eventChannel =
      EventChannel('samples.flutter.io/charging');

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent as void Function(dynamic event)?, onError: _onError);
  }

  void _onEvent(Object object) {
    print("eventchannel _onEvent is=>" + object.toString());
  }

  void _onError(Object object) {
    print("eventchannel  _onError is=>" + object.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
