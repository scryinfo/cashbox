///
//  Generated code. Do not modify.
//  source: refresh_open.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class RefreshOpen_ConnectParameterRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshOpen.ConnectParameterRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateTime', protoName: 'updateTime')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createTime', protoName: 'createTime')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'optimisticLockVersion', protoName: 'optimisticLockVersion')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cAPem', protoName: 'cAPem')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'servicePem', protoName: 'servicePem')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxKey', protoName: 'cashboxKey')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxPem', protoName: 'cashboxPem')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remark')
    ..aOM<$0.Err>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  RefreshOpen_ConnectParameterRes._() : super();
  factory RefreshOpen_ConnectParameterRes({
    $core.String? id,
    $fixnum.Int64? updateTime,
    $fixnum.Int64? createTime,
    $fixnum.Int64? optimisticLockVersion,
    $core.String? host,
    $fixnum.Int64? port,
    $core.String? cAPem,
    $core.String? servicePem,
    $core.String? cashboxKey,
    $core.String? cashboxPem,
    $core.String? remark,
    $0.Err? err,
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
    if (cAPem != null) {
      _result.cAPem = cAPem;
    }
    if (servicePem != null) {
      _result.servicePem = servicePem;
    }
    if (cashboxKey != null) {
      _result.cashboxKey = cashboxKey;
    }
    if (cashboxPem != null) {
      _result.cashboxPem = cashboxPem;
    }
    if (remark != null) {
      _result.remark = remark;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory RefreshOpen_ConnectParameterRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshOpen_ConnectParameterRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshOpen_ConnectParameterRes clone() => RefreshOpen_ConnectParameterRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshOpen_ConnectParameterRes copyWith(void Function(RefreshOpen_ConnectParameterRes) updates) => super.copyWith((message) => updates(message as RefreshOpen_ConnectParameterRes)) as RefreshOpen_ConnectParameterRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshOpen_ConnectParameterRes create() => RefreshOpen_ConnectParameterRes._();
  RefreshOpen_ConnectParameterRes createEmptyInstance() => create();
  static $pb.PbList<RefreshOpen_ConnectParameterRes> createRepeated() => $pb.PbList<RefreshOpen_ConnectParameterRes>();
  @$core.pragma('dart2js:noInline')
  static RefreshOpen_ConnectParameterRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshOpen_ConnectParameterRes>(create);
  static RefreshOpen_ConnectParameterRes? _defaultInstance;

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
  $core.String get cAPem => $_getSZ(6);
  @$pb.TagNumber(7)
  set cAPem($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCAPem() => $_has(6);
  @$pb.TagNumber(7)
  void clearCAPem() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get servicePem => $_getSZ(7);
  @$pb.TagNumber(8)
  set servicePem($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasServicePem() => $_has(7);
  @$pb.TagNumber(8)
  void clearServicePem() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get cashboxKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set cashboxKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCashboxKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearCashboxKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get cashboxPem => $_getSZ(9);
  @$pb.TagNumber(10)
  set cashboxPem($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCashboxPem() => $_has(9);
  @$pb.TagNumber(10)
  void clearCashboxPem() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get remark => $_getSZ(10);
  @$pb.TagNumber(11)
  set remark($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRemark() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemark() => clearField(11);

  @$pb.TagNumber(12)
  $0.Err get err => $_getN(11);
  @$pb.TagNumber(12)
  set err($0.Err v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasErr() => $_has(11);
  @$pb.TagNumber(12)
  void clearErr() => clearField(12);
  @$pb.TagNumber(12)
  $0.Err ensureErr() => $_ensure(11);
}

class RefreshOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RefreshOpen._() : super();
  factory RefreshOpen() => create();
  factory RefreshOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshOpen clone() => RefreshOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshOpen copyWith(void Function(RefreshOpen) updates) => super.copyWith((message) => updates(message as RefreshOpen)) as RefreshOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshOpen create() => RefreshOpen._();
  RefreshOpen createEmptyInstance() => create();
  static $pb.PbList<RefreshOpen> createRepeated() => $pb.PbList<RefreshOpen>();
  @$core.pragma('dart2js:noInline')
  static RefreshOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshOpen>(create);
  static RefreshOpen? _defaultInstance;
}

