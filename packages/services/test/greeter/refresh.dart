import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';
import 'package:services/src/rpc_face/refresh.pbgrpc.dart';

import 'server.dart';

class RefreshService extends RefreshFaceServiceBase {
  @override
  Future<Refresh_RefreshRes> refresh(
      ServiceCall call, Refresh_RefreshReq request) async {
    Refresh_RefreshRes re = new Refresh_RefreshRes();
    re.serviceMeta = new Refresh_ServiceMeta();
    bool odd = true;
    if (request.version != "1") {
      odd = false;
    }
    if (odd) {
      re.serviceMeta.host = "localhost";
      re.serviceMeta.port = Int64(server1Port);
    } else {
      re.serviceMeta.host = "localhost";
      re.serviceMeta.port = Int64(server2Port);
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
