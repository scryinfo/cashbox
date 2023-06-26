//
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
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
import 'cashbox_version_open.pb.dart' as $2;

export 'cashbox_version_open.pb.dart';

@$pb.GrpcServiceName('rpc_face.CashboxVersionOpenFace')
class CashboxVersionOpenFaceClient extends $grpc.Client {
  static final _$upgrade = $grpc.ClientMethod<$0.BasicClientReq, $2.CashboxVersionOpen_UpgradeRes>(
      '/rpc_face.CashboxVersionOpenFace/Upgrade',
      ($0.BasicClientReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.CashboxVersionOpen_UpgradeRes.fromBuffer(value));

  CashboxVersionOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.CashboxVersionOpen_UpgradeRes> upgrade($0.BasicClientReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$upgrade, request, options: options);
  }
}

@$pb.GrpcServiceName('rpc_face.CashboxVersionOpenFace')
abstract class CashboxVersionOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CashboxVersionOpenFace';

  CashboxVersionOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq, $2.CashboxVersionOpen_UpgradeRes>(
        'Upgrade',
        upgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($2.CashboxVersionOpen_UpgradeRes value) => value.writeToBuffer()));
  }

  $async.Future<$2.CashboxVersionOpen_UpgradeRes> upgrade_Pre($grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return upgrade(call, await request);
  }

  $async.Future<$2.CashboxVersionOpen_UpgradeRes> upgrade($grpc.ServiceCall call, $0.BasicClientReq request);
}
