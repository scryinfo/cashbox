///
//  Generated code. Do not modify.
//  source: refresh_open.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'base.pb.dart' as $0;
import 'refresh_open.pb.dart' as $3;
export 'refresh_open.pb.dart';

class RefreshOpenFaceClient extends $grpc.Client {
  static final _$connectParameter =
      $grpc.ClientMethod<$0.BasicClientReq, $3.RefreshOpen_ConnectParameterRes>(
          '/rpc_face.RefreshOpenFace/ConnectParameter',
          ($0.BasicClientReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.RefreshOpen_ConnectParameterRes.fromBuffer(value));

  RefreshOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.RefreshOpen_ConnectParameterRes> connectParameter(
      $0.BasicClientReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectParameter, request, options: options);
  }
}

abstract class RefreshOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.RefreshOpenFace';

  RefreshOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq,
            $3.RefreshOpen_ConnectParameterRes>(
        'ConnectParameter',
        connectParameter_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($3.RefreshOpen_ConnectParameterRes value) => value.writeToBuffer()));
  }

  $async.Future<$3.RefreshOpen_ConnectParameterRes> connectParameter_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return connectParameter(call, await request);
  }

  $async.Future<$3.RefreshOpen_ConnectParameterRes> connectParameter(
      $grpc.ServiceCall call, $0.BasicClientReq request);
}
