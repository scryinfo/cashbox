import 'package:grpc/grpc.dart';

import 'server.dart';

Future<void> main(List<String> args) async {
  final port = args.isNotEmpty ? int.parse(args[0]) : server1Port;
  final server = Server([GreeterService(port)]);
  await server.serve(address: 'localhost', port: port);
  print('Server listening on port ${server.port}...');
}
