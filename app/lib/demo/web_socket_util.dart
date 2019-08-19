import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
//配置链接地址  ws://echo.websocket.org

class DemoSocketWidget extends StatefulWidget {
  final String title;
  final WebSocketChannel socketChannel;

  DemoSocketWidget({Key key, this.title, this.socketChannel}) : super(key: key);

  @override
  _DemoSocketWidgetState createState() =>
      _DemoSocketWidgetState(title: title, socketChannel: socketChannel);
}

class _DemoSocketWidgetState extends State<DemoSocketWidget> {
  final String title;
  WebSocketChannel socketChannel;

  _DemoSocketWidgetState({
    Key key,
    this.title,
    this.socketChannel,
  });

  @override
  void initState() {
    super.initState();
    socketChannel =
        IOWebSocketChannel.connect('ws://echo.websocket.org'); //与服务器 建立连接
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new StreamBuilder(
          stream: widget.socketChannel.stream, //监听来自服务器的信息  Stream
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
    widget.socketChannel.sink.add("发消息给服务器"); //发消息给服务器
  }

  @override
  void dispose() {
    //记得把socket关了
    widget.socketChannel.sink.close();
    super.dispose();
  }
}
