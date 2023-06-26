import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
//Configure link address  ws://echo.websocket.org

class DemoSocketWidget extends StatefulWidget {
  final String title;
  final WebSocketChannel socketChannel;

  DemoSocketWidget({Key? key, required this.title, required this.socketChannel}) : super(key: key);

  @override
  _DemoSocketWidgetState createState() =>
      _DemoSocketWidgetState(title: title, socketChannel: socketChannel);
}

class _DemoSocketWidgetState extends State<DemoSocketWidget> {
  final String title;
  WebSocketChannel socketChannel;

  _DemoSocketWidgetState({
    Key? key,
    required this.title,
    required this.socketChannel,
  });

  @override
  void initState() {
    super.initState();
    socketChannel = IOWebSocketChannel.connect(
        'ws://echo.websocket.org'); //Establish a connection with the server
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new StreamBuilder(
          stream: widget.socketChannel.stream,
          //Listen for information from the server Stream
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                  snapshot.hasData ? '${snapshot.data}' : "no data state!~"),
            );
          }),
    );
  }

  void _sendMessage() {
    widget.socketChannel.sink.add("发消息给服务器"); //Send a message to the server
  }

  @override
  void dispose() {
    //Remember to close the socket
    widget.socketChannel.sink.close();
    super.dispose();
  }
}
