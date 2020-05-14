
import 'package:app/global_config/global_config.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RpcUtil{
  doSomething(){
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