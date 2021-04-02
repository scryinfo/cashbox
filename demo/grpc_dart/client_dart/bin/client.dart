// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Dart implementation of the gRPC helloworld.Greeter client.
import 'package:client_dart/src/generated/greeter.pb.dart';
import 'package:client_dart/src/generated/greeter.pbgrpc.dart';
import 'package:grpc/grpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    '192.168.2.5',
    port: 50061,
    options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(minutes: 1)),
  );
  final stub = GreeterClient(channel);

  final name = args.isNotEmpty ? args[0] : 'world';

  for (;;) {
    try {
      var t = 0;
      //todo 当有一次成功调用后，服务端连接断开，再调用rpc方法，进程会terminate，这种处理方式有问题，不管怎么样，也不能退出进程
      final response = await stub.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
    } catch (e) {
      print('Caught error: $e');
    }
  }
  await channel.shutdown();
}
