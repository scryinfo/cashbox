///
import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;

import 'cache.pb.dart' as $2;

export 'cache.pb.dart';

class CacheFaceClient extends $grpc.Client {
  static final _$updateApk =
      $grpc.ClientMethod<$2.CacheKeyReq, $2.UpdateCacheRes>(
          '/rpc_face.CacheFace/UpdateApk',
          ($2.CacheKeyReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UpdateCacheRes.fromBuffer(value));
  static final _$updateAppConfig =
      $grpc.ClientMethod<$2.CacheKeyReq, $2.UpdateCacheRes>(
          '/rpc_face.CacheFace/UpdateAppConfig',
          ($2.CacheKeyReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UpdateCacheRes.fromBuffer(value));
  static final _$verifySignature =
      $grpc.ClientMethod<$2.VerifySignatureReq, $2.VerifySignatureRes>(
          '/rpc_face.CacheFace/VerifySignature',
          ($2.VerifySignatureReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.VerifySignatureRes.fromBuffer(value));
  static final _$getLatestApk =
      $grpc.ClientMethod<$2.CacheKeyReq, $2.LatestApkRes>(
          '/rpc_face.CacheFace/GetLatestApk',
          ($2.CacheKeyReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.LatestApkRes.fromBuffer(value));
  static final _$getApkList = $grpc.ClientMethod<$2.CacheKeyReq, $2.AllApkRes>(
      '/rpc_face.CacheFace/GetApkList',
      ($2.CacheKeyReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AllApkRes.fromBuffer(value));
  static final _$getAppConfig =
      $grpc.ClientMethod<$2.CacheKeyReq, $2.AppConfigRes>(
          '/rpc_face.CacheFace/GetAppConfig',
          ($2.CacheKeyReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.AppConfigRes.fromBuffer(value));

  CacheFaceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UpdateCacheRes> updateApk($2.CacheKeyReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$updateApk, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateCacheRes> updateAppConfig(
      $2.CacheKeyReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$updateAppConfig, request, options: options);
  }

  $grpc.ResponseFuture<$2.VerifySignatureRes> verifySignature(
      $2.VerifySignatureReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$verifySignature, request, options: options);
  }

  $grpc.ResponseFuture<$2.LatestApkRes> getLatestApk($2.CacheKeyReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getLatestApk, request, options: options);
  }

  $grpc.ResponseFuture<$2.AllApkRes> getApkList($2.CacheKeyReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getApkList, request, options: options);
  }

  $grpc.ResponseFuture<$2.AppConfigRes> getAppConfig($2.CacheKeyReq request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getAppConfig, request, options: options);
  }
}

abstract class CacheFaceServiceBase extends $grpc.Service {
  $core.String get $name => 'rpc_face.CacheFace';

  CacheFaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CacheKeyReq, $2.UpdateCacheRes>(
        'UpdateApk',
        updateApk_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CacheKeyReq.fromBuffer(value),
        ($2.UpdateCacheRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CacheKeyReq, $2.UpdateCacheRes>(
        'UpdateAppConfig',
        updateAppConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CacheKeyReq.fromBuffer(value),
        ($2.UpdateCacheRes value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.VerifySignatureReq, $2.VerifySignatureRes>(
            'VerifySignature',
            verifySignature_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.VerifySignatureReq.fromBuffer(value),
            ($2.VerifySignatureRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CacheKeyReq, $2.LatestApkRes>(
        'GetLatestApk',
        getLatestApk_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CacheKeyReq.fromBuffer(value),
        ($2.LatestApkRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CacheKeyReq, $2.AllApkRes>(
        'GetApkList',
        getApkList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CacheKeyReq.fromBuffer(value),
        ($2.AllApkRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CacheKeyReq, $2.AppConfigRes>(
        'GetAppConfig',
        getAppConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CacheKeyReq.fromBuffer(value),
        ($2.AppConfigRes value) => value.writeToBuffer()));
  }

  $async.Future<$2.UpdateCacheRes> updateApk_Pre(
      $grpc.ServiceCall call, $async.Future<$2.CacheKeyReq> request) async {
    return updateApk(call, await request);
  }

  $async.Future<$2.UpdateCacheRes> updateAppConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$2.CacheKeyReq> request) async {
    return updateAppConfig(call, await request);
  }

  $async.Future<$2.VerifySignatureRes> verifySignature_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.VerifySignatureReq> request) async {
    return verifySignature(call, await request);
  }

  $async.Future<$2.LatestApkRes> getLatestApk_Pre(
      $grpc.ServiceCall call, $async.Future<$2.CacheKeyReq> request) async {
    return getLatestApk(call, await request);
  }

  $async.Future<$2.AllApkRes> getApkList_Pre(
      $grpc.ServiceCall call, $async.Future<$2.CacheKeyReq> request) async {
    return getApkList(call, await request);
  }

  $async.Future<$2.AppConfigRes> getAppConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$2.CacheKeyReq> request) async {
    return getAppConfig(call, await request);
  }

  $async.Future<$2.UpdateCacheRes> updateApk(
      $grpc.ServiceCall call, $2.CacheKeyReq request);

  $async.Future<$2.UpdateCacheRes> updateAppConfig(
      $grpc.ServiceCall call, $2.CacheKeyReq request);

  $async.Future<$2.VerifySignatureRes> verifySignature(
      $grpc.ServiceCall call, $2.VerifySignatureReq request);

  $async.Future<$2.LatestApkRes> getLatestApk(
      $grpc.ServiceCall call, $2.CacheKeyReq request);

  $async.Future<$2.AllApkRes> getApkList(
      $grpc.ServiceCall call, $2.CacheKeyReq request);

  $async.Future<$2.AppConfigRes> getAppConfig(
      $grpc.ServiceCall call, $2.CacheKeyReq request);
}
