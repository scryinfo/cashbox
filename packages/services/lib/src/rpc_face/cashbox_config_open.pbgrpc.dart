//
//  Generated code. Do not modify.
//  source: cashbox_config_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;
import 'cashbox_config_open.pb.dart' as $1;

export 'cashbox_config_open.pb.dart';

@$pb.GrpcServiceName('rpc_face.CashboxConfigOpenFace')
class CashboxConfigOpenFaceClient extends $grpc.Client {
  static final _$latestConfig = $grpc.ClientMethod<$0.BasicClientReq, $1.CashboxConfigOpen_LatestConfigRes>(
      '/rpc_face.CashboxConfigOpenFace/LatestConfig',
      ($0.BasicClientReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CashboxConfigOpen_LatestConfigRes.fromBuffer(value));

  CashboxConfigOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.CashboxConfigOpen_LatestConfigRes> latestConfig($0.BasicClientReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$latestConfig, request, options: options);
  }
}

@$pb.GrpcServiceName('rpc_face.CashboxConfigOpenFace')
abstract class CashboxConfigOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CashboxConfigOpenFace';

  CashboxConfigOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq, $1.CashboxConfigOpen_LatestConfigRes>(
        'LatestConfig',
        latestConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($1.CashboxConfigOpen_LatestConfigRes value) => value.writeToBuffer()));
  }

  $async.Future<$1.CashboxConfigOpen_LatestConfigRes> latestConfig_Pre($grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return latestConfig(call, await request);
  }

  $async.Future<$1.CashboxConfigOpen_LatestConfigRes> latestConfig($grpc.ServiceCall call, $0.BasicClientReq request);
}
