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
