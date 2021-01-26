///
//  Generated code. Do not modify.
//  source: refresh.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $1;

class Refresh_ServiceMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Refresh.ServiceMeta', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateTime', protoName: 'updateTime')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createTime', protoName: 'createTime')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'optimisticLockVersion', protoName: 'optimisticLockVersion')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certificate')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceStatus', protoName: 'serviceStatus')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remark')
    ..hasRequiredFields = false
  ;

  Refresh_ServiceMeta._() : super();
  factory Refresh_ServiceMeta({
    $core.String id,
    $fixnum.Int64 updateTime,
    $fixnum.Int64 createTime,
    $fixnum.Int64 optimisticLockVersion,
    $core.String host,
    $fixnum.Int64 port,
    $core.String certificate,
    $core.String serviceStatus,
    $core.String remark,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (updateTime != null) {
      _result.updateTime = updateTime;
    }
    if (createTime != null) {
      _result.createTime = createTime;
    }
    if (optimisticLockVersion != null) {
      _result.optimisticLockVersion = optimisticLockVersion;
    }
    if (host != null) {
      _result.host = host;
    }
    if (port != null) {
      _result.port = port;
    }
    if (certificate != null) {
      _result.certificate = certificate;
    }
    if (serviceStatus != null) {
      _result.serviceStatus = serviceStatus;
    }
    if (remark != null) {
      _result.remark = remark;
    }
    return _result;
  }
  factory Refresh_ServiceMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Refresh_ServiceMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Refresh_ServiceMeta clone() => Refresh_ServiceMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Refresh_ServiceMeta copyWith(void Function(Refresh_ServiceMeta) updates) => super.copyWith((message) => updates(message as Refresh_ServiceMeta)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Refresh_ServiceMeta create() => Refresh_ServiceMeta._();
  Refresh_ServiceMeta createEmptyInstance() => create();
  static $pb.PbList<Refresh_ServiceMeta> createRepeated() => $pb.PbList<Refresh_ServiceMeta>();
  @$core.pragma('dart2js:noInline')
  static Refresh_ServiceMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Refresh_ServiceMeta>(create);
  static Refresh_ServiceMeta _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get updateTime => $_getI64(1);
  @$pb.TagNumber(2)
  set updateTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateTime() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get createTime => $_getI64(2);
  @$pb.TagNumber(3)
  set createTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreateTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreateTime() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get optimisticLockVersion => $_getI64(3);
  @$pb.TagNumber(4)
  set optimisticLockVersion($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOptimisticLockVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearOptimisticLockVersion() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get host => $_getSZ(4);
  @$pb.TagNumber(5)
  set host($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHost() => $_has(4);
  @$pb.TagNumber(5)
  void clearHost() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get port => $_getI64(5);
  @$pb.TagNumber(6)
  set port($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPort() => $_has(5);
  @$pb.TagNumber(6)
  void clearPort() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get certificate => $_getSZ(6);
  @$pb.TagNumber(7)
  set certificate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCertificate() => $_has(6);
  @$pb.TagNumber(7)
  void clearCertificate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get serviceStatus => $_getSZ(7);
  @$pb.TagNumber(8)
  set serviceStatus($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServiceStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearServiceStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get remark => $_getSZ(8);
  @$pb.TagNumber(9)
  set remark($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRemark() => $_has(8);
  @$pb.TagNumber(9)
  void clearRemark() => clearField(9);
}

class Refresh_RefreshReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Refresh.RefreshReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appPlatformType', protoName: 'appPlatformType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sign')
    ..hasRequiredFields = false
  ;

  Refresh_RefreshReq._() : super();
  factory Refresh_RefreshReq({
    $core.String version,
    $core.String appPlatformType,
    $core.String sign,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    if (appPlatformType != null) {
      _result.appPlatformType = appPlatformType;
    }
    if (sign != null) {
      _result.sign = sign;
    }
    return _result;
  }
  factory Refresh_RefreshReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Refresh_RefreshReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Refresh_RefreshReq clone() => Refresh_RefreshReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Refresh_RefreshReq copyWith(void Function(Refresh_RefreshReq) updates) => super.copyWith((message) => updates(message as Refresh_RefreshReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Refresh_RefreshReq create() => Refresh_RefreshReq._();
  Refresh_RefreshReq createEmptyInstance() => create();
  static $pb.PbList<Refresh_RefreshReq> createRepeated() => $pb.PbList<Refresh_RefreshReq>();
  @$core.pragma('dart2js:noInline')
  static Refresh_RefreshReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Refresh_RefreshReq>(create);
  static Refresh_RefreshReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appPlatformType => $_getSZ(1);
  @$pb.TagNumber(2)
  set appPlatformType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppPlatformType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppPlatformType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sign => $_getSZ(2);
  @$pb.TagNumber(3)
  set sign($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSign() => $_has(2);
  @$pb.TagNumber(3)
  void clearSign() => clearField(3);
}

class Refresh_RefreshRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Refresh.RefreshRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..aOM<Refresh_ServiceMeta>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceMeta', protoName: 'serviceMeta', subBuilder: Refresh_ServiceMeta.create)
    ..hasRequiredFields = false
  ;

  Refresh_RefreshRes._() : super();
  factory Refresh_RefreshRes({
    $1.Err err,
    Refresh_ServiceMeta serviceMeta,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (serviceMeta != null) {
      _result.serviceMeta = serviceMeta;
    }
    return _result;
  }
  factory Refresh_RefreshRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Refresh_RefreshRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Refresh_RefreshRes clone() => Refresh_RefreshRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Refresh_RefreshRes copyWith(void Function(Refresh_RefreshRes) updates) => super.copyWith((message) => updates(message as Refresh_RefreshRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Refresh_RefreshRes create() => Refresh_RefreshRes._();
  Refresh_RefreshRes createEmptyInstance() => create();
  static $pb.PbList<Refresh_RefreshRes> createRepeated() => $pb.PbList<Refresh_RefreshRes>();
  @$core.pragma('dart2js:noInline')
  static Refresh_RefreshRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Refresh_RefreshRes>(create);
  static Refresh_RefreshRes _defaultInstance;

  @$pb.TagNumber(1)
  $1.Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err($1.Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  $1.Err ensureErr() => $_ensure(0);

  @$pb.TagNumber(2)
  Refresh_ServiceMeta get serviceMeta => $_getN(1);
  @$pb.TagNumber(2)
  set serviceMeta(Refresh_ServiceMeta v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasServiceMeta() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceMeta() => clearField(2);
  @$pb.TagNumber(2)
  Refresh_ServiceMeta ensureServiceMeta() => $_ensure(1);
}

class Refresh extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Refresh', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Refresh._() : super();
  factory Refresh() => create();
  factory Refresh.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Refresh.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Refresh clone() => Refresh()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Refresh copyWith(void Function(Refresh) updates) => super.copyWith((message) => updates(message as Refresh)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Refresh create() => Refresh._();
  Refresh createEmptyInstance() => create();
  static $pb.PbList<Refresh> createRepeated() => $pb.PbList<Refresh>();
  @$core.pragma('dart2js:noInline')
  static Refresh getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Refresh>(create);
  static Refresh _defaultInstance;
}

