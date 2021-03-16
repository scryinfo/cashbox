///
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'token_open.pb.dart' as $4;
import 'base.pb.dart' as $0;
export 'token_open.pb.dart';

class EthTokenOpenFaceClient extends $grpc.Client {
  static final _$query =
      $grpc.ClientMethod<$4.EthTokenOpen_QueryReq, $4.EthTokenOpen_QueryRes>(
          '/rpc_face.EthTokenOpenFace/Query',
          ($4.EthTokenOpen_QueryReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.EthTokenOpen_QueryRes.fromBuffer(value));

  EthTokenOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$4.EthTokenOpen_QueryRes> query(
      $4.EthTokenOpen_QueryReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$query, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class EthTokenOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.EthTokenOpenFace';

  EthTokenOpenFaceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$4.EthTokenOpen_QueryReq, $4.EthTokenOpen_QueryRes>(
            'Query',
            query_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.EthTokenOpen_QueryReq.fromBuffer(value),
            ($4.EthTokenOpen_QueryRes value) => value.writeToBuffer()));
  }

  $async.Future<$4.EthTokenOpen_QueryRes> query_Pre($grpc.ServiceCall call,
      $async.Future<$4.EthTokenOpen_QueryReq> request) async {
    return query(call, await request);
  }

  $async.Future<$4.EthTokenOpen_QueryRes> query(
      $grpc.ServiceCall call, $4.EthTokenOpen_QueryReq request);
}

class TokenOpenFaceClient extends $grpc.Client {
  static final _$priceRate =
      $grpc.ClientMethod<$0.BasicClientReq, $4.TokenOpen_PriceRateRes>(
          '/rpc_face.TokenOpenFace/PriceRate',
          ($0.BasicClientReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.TokenOpen_PriceRateRes.fromBuffer(value));

  TokenOpenFaceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$4.TokenOpen_PriceRateRes> priceRate(
      $0.BasicClientReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$priceRate, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class TokenOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.TokenOpenFace';

  TokenOpenFaceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.BasicClientReq, $4.TokenOpen_PriceRateRes>(
            'PriceRate',
            priceRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BasicClientReq.fromBuffer(value),
            ($4.TokenOpen_PriceRateRes value) => value.writeToBuffer()));
  }

  $async.Future<$4.TokenOpen_PriceRateRes> priceRate_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return priceRate(call, await request);
  }

  $async.Future<$4.TokenOpen_PriceRateRes> priceRate(
      $grpc.ServiceCall call, $0.BasicClientReq request);
}
