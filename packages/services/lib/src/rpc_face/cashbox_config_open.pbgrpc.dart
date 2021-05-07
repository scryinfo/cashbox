///
//  Generated code. Do not modify.
//  source: cashbox_config_open.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'base.pb.dart' as $0;
import 'cashbox_config_open.pb.dart' as $1;
export 'cashbox_config_open.pb.dart';

class CashboxConfigOpenFaceClient extends $grpc.Client {
  static final _$latestConfig = $grpc.ClientMethod<$0.BasicClientReq,
          $1.CashboxConfigOpen_LatestConfigRes>(
      '/rpc_face.CashboxConfigOpenFace/LatestConfig',
      ($0.BasicClientReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CashboxConfigOpen_LatestConfigRes.fromBuffer(value));

  CashboxConfigOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.CashboxConfigOpen_LatestConfigRes> latestConfig(
      $0.BasicClientReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$latestConfig, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class CashboxConfigOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CashboxConfigOpenFace';

  CashboxConfigOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq,
            $1.CashboxConfigOpen_LatestConfigRes>(
        'LatestConfig',
        latestConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($1.CashboxConfigOpen_LatestConfigRes value) => value.writeToBuffer()));
  }

  $async.Future<$1.CashboxConfigOpen_LatestConfigRes> latestConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return latestConfig(call, await request);
  }

  $async.Future<$1.CashboxConfigOpen_LatestConfigRes> latestConfig(
      $grpc.ServiceCall call, $0.BasicClientReq request);
}
