

class RpcUtil {
  doSomething() {
    /*StreamChannel socket = HtmlWebSocketChannel.connect(GlobalConfig.ipAddress);
    var client = new json_rpc.Client(socket);
    client.sendRequest("").then((result)=>
      print("state_getRuntime is $result")
    );
    client.listen();*/

    /*WebSocketChannel channel = new IOWebSocketChannel.connect(GlobalConfig.ipAddress);
    channel.sink.add("state_getRuntimeVersion");
    channel.stream.listen((data){
      print("websocket back is ======================>"+data.toString());

    });*/
  }
}
