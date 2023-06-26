//
//  Generated code. Do not modify.
//  source: token_open.proto
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
import 'token_open.pb.dart' as $4;

export 'token_open.pb.dart';

@$pb.GrpcServiceName('rpc_face.EthTokenOpenFace')
class EthTokenOpenFaceClient extends $grpc.Client {
  static final _$query = $grpc.ClientMethod<$4.EthTokenOpen_QueryReq, $4.EthTokenOpen_QueryRes>(
      '/rpc_face.EthTokenOpenFace/Query',
      ($4.EthTokenOpen_QueryReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.EthTokenOpen_QueryRes.fromBuffer(value));

  EthTokenOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.EthTokenOpen_QueryRes> query($4.EthTokenOpen_QueryReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$query, request, options: options);
  }
}

@$pb.GrpcServiceName('rpc_face.EthTokenOpenFace')
abstract class EthTokenOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.EthTokenOpenFace';

  EthTokenOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.EthTokenOpen_QueryReq, $4.EthTokenOpen_QueryRes>(
        'Query',
        query_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.EthTokenOpen_QueryReq.fromBuffer(value),
        ($4.EthTokenOpen_QueryRes value) => value.writeToBuffer()));
  }

  $async.Future<$4.EthTokenOpen_QueryRes> query_Pre($grpc.ServiceCall call, $async.Future<$4.EthTokenOpen_QueryReq> request) async {
    return query(call, await request);
  }

  $async.Future<$4.EthTokenOpen_QueryRes> query($grpc.ServiceCall call, $4.EthTokenOpen_QueryReq request);
}
@$pb.GrpcServiceName('rpc_face.EeeTokenOpenFace')
class EeeTokenOpenFaceClient extends $grpc.Client {
  static final _$query = $grpc.ClientMethod<$4.EeeTokenOpen_QueryReq, $4.EeeTokenOpen_QueryRes>(
      '/rpc_face.EeeTokenOpenFace/Query',
      ($4.EeeTokenOpen_QueryReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.EeeTokenOpen_QueryRes.fromBuffer(value));

  EeeTokenOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.EeeTokenOpen_QueryRes> query($4.EeeTokenOpen_QueryReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$query, request, options: options);
  }
}

@$pb.GrpcServiceName('rpc_face.EeeTokenOpenFace')
abstract class EeeTokenOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.EeeTokenOpenFace';

  EeeTokenOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.EeeTokenOpen_QueryReq, $4.EeeTokenOpen_QueryRes>(
        'Query',
        query_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.EeeTokenOpen_QueryReq.fromBuffer(value),
        ($4.EeeTokenOpen_QueryRes value) => value.writeToBuffer()));
  }

  $async.Future<$4.EeeTokenOpen_QueryRes> query_Pre($grpc.ServiceCall call, $async.Future<$4.EeeTokenOpen_QueryReq> request) async {
    return query(call, await request);
  }

  $async.Future<$4.EeeTokenOpen_QueryRes> query($grpc.ServiceCall call, $4.EeeTokenOpen_QueryReq request);
}
@$pb.GrpcServiceName('rpc_face.TokenOpenFace')
class TokenOpenFaceClient extends $grpc.Client {
  static final _$priceRate = $grpc.ClientMethod<$0.BasicClientReq, $4.TokenOpen_PriceRateRes>(
      '/rpc_face.TokenOpenFace/PriceRate',
      ($0.BasicClientReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.TokenOpen_PriceRateRes.fromBuffer(value));

  TokenOpenFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.TokenOpen_PriceRateRes> priceRate($0.BasicClientReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$priceRate, request, options: options);
  }
}

@$pb.GrpcServiceName('rpc_face.TokenOpenFace')
abstract class TokenOpenFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.TokenOpenFace';

  TokenOpenFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BasicClientReq, $4.TokenOpen_PriceRateRes>(
        'PriceRate',
        priceRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BasicClientReq.fromBuffer(value),
        ($4.TokenOpen_PriceRateRes value) => value.writeToBuffer()));
  }

  $async.Future<$4.TokenOpen_PriceRateRes> priceRate_Pre($grpc.ServiceCall call, $async.Future<$0.BasicClientReq> request) async {
    return priceRate(call, await request);
  }

  $async.Future<$4.TokenOpen_PriceRateRes> priceRate($grpc.ServiceCall call, $0.BasicClientReq request);
}
