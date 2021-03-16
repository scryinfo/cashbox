///
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'base.pb.dart' as $0;
import 'cashbox_version_open.pb.dart' as $2;
export 'cashbox_version_open.pb.dart';

class CashboxVersionOpenFaceClient extends $grpc.Client {
  static final _$upgrade =
      $grpc.ClientMethod<$0.BasicClientReq, $2.CashboxVersionOpen_UpgradeRes>(
          '/rpc_face.CashboxVersionOpenFace/Upgrade',
          ($0.BasicClientReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.CashboxVersionOpen_UpgradeRes.fromBuffer(value));

  CashboxVersionOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$2.CashboxVersionOpen_UpgradeRes> upgrade(
      $0.BasicClientReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$upgrade, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class CashboxVersionOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CashboxVersionOpenFace';

  CashboxVersionOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq,
            $2.CashboxVersionOpen_UpgradeRes>(
        'Upgrade',
        upgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($2.CashboxVersionOpen_UpgradeRes value) => value.writeToBuffer()));
  }

  $async.Future<$2.CashboxVersionOpen_UpgradeRes> upgrade_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return upgrade(call, await request);
  }

  $async.Future<$2.CashboxVersionOpen_UpgradeRes> upgrade(
      $grpc.ServiceCall call, $0.BasicClientReq request);
}
