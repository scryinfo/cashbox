import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/refresh_open.pbgrpc.dart';

import 'server.dart';

class RefreshService extends RefreshOpenFaceServiceBase {
  @override
  Future<RefreshOpen_ConnectParameterRes> connectParameter(
      ServiceCall call, BasicClientReq request) async {
    RefreshOpen_ConnectParameterRes re = new RefreshOpen_ConnectParameterRes();
    bool odd = true;
    if (request.cashboxVersion != "1") {
      odd = false;
    }
    if (odd) {
      re.host = "localhost";
      re.port = Int64(server1Port);
    } else {
      re.host = "localhost";
      re.port = Int64(server2Port);
    }
    return re;
  }

}

const serverRefreshPort = 50050;

Future<Server> runRefreshServer(int port) async {
  final server = Server([RefreshService()]);
  await server.serve(
    address: 'localhost',
    port: port,
  );
  print('Server listening on port ${server.port}...');
  // await Future.delayed(Duration(days: 1));
  return server;
}
