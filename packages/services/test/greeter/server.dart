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

/// Dart implementation of the gRPC helloworld.Greeter server.
import 'package:grpc/grpc.dart';

import 'greeter.pbgrpc.dart';

class GreeterService extends GreeterServiceBase {
  int _port;

  GreeterService(this._port);

  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return HelloReply()..message = 'port: $_port -- Hello ${request.name}!';
  }
}

const server1Port = 50051;
const server2Port = 50052;

Future<Server> runServer(int port) async {
  final server = Server([GreeterService(port)]);
  await server.serve(
    address: 'localhost',
    port: port,
  );
  print('Server listening on port ${server.port}...');
  // await Future.delayed(Duration(days: 1));
  return server;
}
