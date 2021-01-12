
import 'package:grpc/grpc.dart';

import 'package:client_dart/src/generated/greeter.pb.dart';
import 'package:client_dart/src/generated/greeter.pbgrpc.dart';

class ClientGreeter{
  ClientChannel channel;
  GreeterClient greeterClient;

  init(){
    channel = ClientChannel(
      '192.168.2.5',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    greeterClient = GreeterClient(channel);
  }

  uninit() {
    channel.shutdown();
  }
}