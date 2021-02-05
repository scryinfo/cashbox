///
import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;

import 'refresh.pb.dart' as $3;

export 'refresh.pb.dart';

class RefreshFaceClient extends $grpc.Client {
  static final _$refresh =
      $grpc.ClientMethod<$3.Refresh_RefreshReq, $3.Refresh_RefreshRes>(
          '/rpc_face.RefreshFace/refresh',
          ($3.Refresh_RefreshReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.Refresh_RefreshRes.fromBuffer(value));

  RefreshFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.Refresh_RefreshRes> refresh(
      $3.Refresh_RefreshReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$refresh, request, options: options);
  }
}

abstract class RefreshFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.RefreshFace';

  RefreshFaceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$3.Refresh_RefreshReq, $3.Refresh_RefreshRes>(
            'refresh',
            refresh_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.Refresh_RefreshReq.fromBuffer(value),
            ($3.Refresh_RefreshRes value) => value.writeToBuffer()));
  }

  $async.Future<$3.Refresh_RefreshRes> refresh_Pre($grpc.ServiceCall call,
      $async.Future<$3.Refresh_RefreshReq> request) async {
    return refresh(call, await request);
  }

  $async.Future<$3.Refresh_RefreshRes> refresh(
      $grpc.ServiceCall call, $3.Refresh_RefreshReq request);
}
