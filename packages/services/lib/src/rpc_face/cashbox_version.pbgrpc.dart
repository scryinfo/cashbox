///
//  Generated code. Do not modify.
//  source: cashbox_version.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'cashbox_version.pb.dart' as $0;
import 'base.pb.dart' as $1;
export 'cashbox_version.pb.dart';

class CashboxVersionFaceClient extends $grpc.Client {
  static final _$save =
      $grpc.ClientMethod<$0.CashboxVersion_SaveReq, $0.CashboxVersion_SaveRes>(
          '/rpc_face.CashboxVersionFace/Save',
          ($0.CashboxVersion_SaveReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CashboxVersion_SaveRes.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.DeleteReq, $1.DeleteRes>(
      '/rpc_face.CashboxVersionFace/Delete',
      ($1.DeleteReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DeleteRes.fromBuffer(value));
  static final _$status =
      $grpc.ClientMethod<$1.RecordStatusReq, $1.RecordStatusRes>(
          '/rpc_face.CashboxVersionFace/Status',
          ($1.RecordStatusReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.RecordStatusRes.fromBuffer(value));
  static final _$query = $grpc.ClientMethod<$0.CashboxVersion_QueryReq,
          $0.CashboxVersion_QueryRes>(
      '/rpc_face.CashboxVersionFace/Query',
      ($0.CashboxVersion_QueryReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CashboxVersion_QueryRes.fromBuffer(value));
  static final _$getById =
      $grpc.ClientMethod<$1.GetByIdReq, $0.CashboxVersion_GetByIdRes>(
          '/rpc_face.CashboxVersionFace/GetById',
          ($1.GetByIdReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CashboxVersion_GetByIdRes.fromBuffer(value));

  CashboxVersionFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CashboxVersion_SaveRes> save(
      $0.CashboxVersion_SaveReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$save, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteRes> delete($1.DeleteReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$1.RecordStatusRes> status($1.RecordStatusReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$status, request, options: options);
  }

  $grpc.ResponseFuture<$0.CashboxVersion_QueryRes> query(
      $0.CashboxVersion_QueryReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$query, request, options: options);
  }

  $grpc.ResponseFuture<$0.CashboxVersion_GetByIdRes> getById(
      $1.GetByIdReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getById, request, options: options);
  }
}

abstract class CashboxVersionFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CashboxVersionFace';

  CashboxVersionFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CashboxVersion_SaveReq,
            $0.CashboxVersion_SaveRes>(
        'Save',
        save_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CashboxVersion_SaveReq.fromBuffer(value),
        ($0.CashboxVersion_SaveRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteReq, $1.DeleteRes>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeleteReq.fromBuffer(value),
        ($1.DeleteRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RecordStatusReq, $1.RecordStatusRes>(
        'Status',
        status_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RecordStatusReq.fromBuffer(value),
        ($1.RecordStatusRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CashboxVersion_QueryReq,
            $0.CashboxVersion_QueryRes>(
        'Query',
        query_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CashboxVersion_QueryReq.fromBuffer(value),
        ($0.CashboxVersion_QueryRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetByIdReq, $0.CashboxVersion_GetByIdRes>(
        'GetById',
        getById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetByIdReq.fromBuffer(value),
        ($0.CashboxVersion_GetByIdRes value) => value.writeToBuffer()));
  }

  $async.Future<$0.CashboxVersion_SaveRes> save_Pre($grpc.ServiceCall call,
      $async.Future<$0.CashboxVersion_SaveReq> request) async {
    return save(call, await request);
  }

  $async.Future<$1.DeleteRes> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.DeleteReq> request) async {
    return delete(call, await request);
  }

  $async.Future<$1.RecordStatusRes> status_Pre(
      $grpc.ServiceCall call, $async.Future<$1.RecordStatusReq> request) async {
    return status(call, await request);
  }

  $async.Future<$0.CashboxVersion_QueryRes> query_Pre($grpc.ServiceCall call,
      $async.Future<$0.CashboxVersion_QueryReq> request) async {
    return query(call, await request);
  }

  $async.Future<$0.CashboxVersion_GetByIdRes> getById_Pre(
      $grpc.ServiceCall call, $async.Future<$1.GetByIdReq> request) async {
    return getById(call, await request);
  }

  $async.Future<$0.CashboxVersion_SaveRes> save(
      $grpc.ServiceCall call, $0.CashboxVersion_SaveReq request);
  $async.Future<$1.DeleteRes> delete(
      $grpc.ServiceCall call, $1.DeleteReq request);
  $async.Future<$1.RecordStatusRes> status(
      $grpc.ServiceCall call, $1.RecordStatusReq request);
  $async.Future<$0.CashboxVersion_QueryRes> query(
      $grpc.ServiceCall call, $0.CashboxVersion_QueryReq request);
  $async.Future<$0.CashboxVersion_GetByIdRes> getById(
      $grpc.ServiceCall call, $1.GetByIdReq request);
}
