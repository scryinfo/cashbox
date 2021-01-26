///
//  Generated code. Do not modify.
//  source: cache.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $1;
import 'cashbox_version.pb.dart' as $0;

class CacheKeyReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CacheKeyReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..hasRequiredFields = false
  ;

  CacheKeyReq._() : super();
  factory CacheKeyReq({
    $core.String key,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory CacheKeyReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CacheKeyReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CacheKeyReq clone() => CacheKeyReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CacheKeyReq copyWith(void Function(CacheKeyReq) updates) => super.copyWith((message) => updates(message as CacheKeyReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CacheKeyReq create() => CacheKeyReq._();
  CacheKeyReq createEmptyInstance() => create();
  static $pb.PbList<CacheKeyReq> createRepeated() => $pb.PbList<CacheKeyReq>();
  @$core.pragma('dart2js:noInline')
  static CacheKeyReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CacheKeyReq>(create);
  static CacheKeyReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);
}

class UpdateCacheRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCacheRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isUpdate', protoName: 'isUpdate')
    ..aOM<$1.Err>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..hasRequiredFields = false
  ;

  UpdateCacheRes._() : super();
  factory UpdateCacheRes({
    $core.bool isUpdate,
    $1.Err err,
  }) {
    final _result = create();
    if (isUpdate != null) {
      _result.isUpdate = isUpdate;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory UpdateCacheRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCacheRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCacheRes clone() => UpdateCacheRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCacheRes copyWith(void Function(UpdateCacheRes) updates) => super.copyWith((message) => updates(message as UpdateCacheRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCacheRes create() => UpdateCacheRes._();
  UpdateCacheRes createEmptyInstance() => create();
  static $pb.PbList<UpdateCacheRes> createRepeated() => $pb.PbList<UpdateCacheRes>();
  @$core.pragma('dart2js:noInline')
  static UpdateCacheRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCacheRes>(create);
  static UpdateCacheRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isUpdate => $_getBF(0);
  @$pb.TagNumber(1)
  set isUpdate($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsUpdate() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsUpdate() => clearField(1);

  @$pb.TagNumber(2)
  $1.Err get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Err v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => clearField(2);
  @$pb.TagNumber(2)
  $1.Err ensureErr() => $_ensure(1);
}

class VerifySignatureReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifySignatureReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<CacheKeyReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', subBuilder: CacheKeyReq.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientSignature', protoName: 'clientSignature')
    ..hasRequiredFields = false
  ;

  VerifySignatureReq._() : super();
  factory VerifySignatureReq({
    CacheKeyReq key,
    $core.String clientSignature,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (clientSignature != null) {
      _result.clientSignature = clientSignature;
    }
    return _result;
  }
  factory VerifySignatureReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifySignatureReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifySignatureReq clone() => VerifySignatureReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifySignatureReq copyWith(void Function(VerifySignatureReq) updates) => super.copyWith((message) => updates(message as VerifySignatureReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifySignatureReq create() => VerifySignatureReq._();
  VerifySignatureReq createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureReq> createRepeated() => $pb.PbList<VerifySignatureReq>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureReq>(create);
  static VerifySignatureReq _defaultInstance;

  @$pb.TagNumber(1)
  CacheKeyReq get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(CacheKeyReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);
  @$pb.TagNumber(1)
  CacheKeyReq ensureKey() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get clientSignature => $_getSZ(1);
  @$pb.TagNumber(2)
  set clientSignature($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClientSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientSignature() => clearField(2);
}

class VerifySignatureRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifySignatureRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validity')
    ..aOM<$1.Err>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..hasRequiredFields = false
  ;

  VerifySignatureRes._() : super();
  factory VerifySignatureRes({
    $core.bool validity,
    $1.Err err,
  }) {
    final _result = create();
    if (validity != null) {
      _result.validity = validity;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory VerifySignatureRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifySignatureRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifySignatureRes clone() => VerifySignatureRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifySignatureRes copyWith(void Function(VerifySignatureRes) updates) => super.copyWith((message) => updates(message as VerifySignatureRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifySignatureRes create() => VerifySignatureRes._();
  VerifySignatureRes createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureRes> createRepeated() => $pb.PbList<VerifySignatureRes>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureRes>(create);
  static VerifySignatureRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get validity => $_getBF(0);
  @$pb.TagNumber(1)
  set validity($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValidity() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidity() => clearField(1);

  @$pb.TagNumber(2)
  $1.Err get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Err v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => clearField(2);
  @$pb.TagNumber(2)
  $1.Err ensureErr() => $_ensure(1);
}

class LatestApkRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LatestApkRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.CashboxVersion_Model>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxVersion', protoName: 'cashboxVersion', subBuilder: $0.CashboxVersion_Model.create)
    ..aOM<$1.Err>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..hasRequiredFields = false
  ;

  LatestApkRes._() : super();
  factory LatestApkRes({
    $0.CashboxVersion_Model cashboxVersion,
    $1.Err err,
  }) {
    final _result = create();
    if (cashboxVersion != null) {
      _result.cashboxVersion = cashboxVersion;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory LatestApkRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LatestApkRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LatestApkRes clone() => LatestApkRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LatestApkRes copyWith(void Function(LatestApkRes) updates) => super.copyWith((message) => updates(message as LatestApkRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LatestApkRes create() => LatestApkRes._();
  LatestApkRes createEmptyInstance() => create();
  static $pb.PbList<LatestApkRes> createRepeated() => $pb.PbList<LatestApkRes>();
  @$core.pragma('dart2js:noInline')
  static LatestApkRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LatestApkRes>(create);
  static LatestApkRes _defaultInstance;

  @$pb.TagNumber(1)
  $0.CashboxVersion_Model get cashboxVersion => $_getN(0);
  @$pb.TagNumber(1)
  set cashboxVersion($0.CashboxVersion_Model v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCashboxVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearCashboxVersion() => clearField(1);
  @$pb.TagNumber(1)
  $0.CashboxVersion_Model ensureCashboxVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Err get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Err v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => clearField(2);
  @$pb.TagNumber(2)
  $1.Err ensureErr() => $_ensure(1);
}

class AllApkRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AllApkRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pc<$0.CashboxVersion_Model>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxVersions', $pb.PbFieldType.PM, protoName: 'cashboxVersions', subBuilder: $0.CashboxVersion_Model.create)
    ..aOM<$1.Err>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..hasRequiredFields = false
  ;

  AllApkRes._() : super();
  factory AllApkRes({
    $core.Iterable<$0.CashboxVersion_Model> cashboxVersions,
    $1.Err err,
  }) {
    final _result = create();
    if (cashboxVersions != null) {
      _result.cashboxVersions.addAll(cashboxVersions);
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory AllApkRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllApkRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllApkRes clone() => AllApkRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllApkRes copyWith(void Function(AllApkRes) updates) => super.copyWith((message) => updates(message as AllApkRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AllApkRes create() => AllApkRes._();
  AllApkRes createEmptyInstance() => create();
  static $pb.PbList<AllApkRes> createRepeated() => $pb.PbList<AllApkRes>();
  @$core.pragma('dart2js:noInline')
  static AllApkRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllApkRes>(create);
  static AllApkRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.CashboxVersion_Model> get cashboxVersions => $_getList(0);

  @$pb.TagNumber(2)
  $1.Err get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Err v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => clearField(2);
  @$pb.TagNumber(2)
  $1.Err ensureErr() => $_ensure(1);
}

class AppConfigRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AppConfigRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conf')
    ..aOM<$1.Err>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..hasRequiredFields = false
  ;

  AppConfigRes._() : super();
  factory AppConfigRes({
    $core.String conf,
    $1.Err err,
  }) {
    final _result = create();
    if (conf != null) {
      _result.conf = conf;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory AppConfigRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppConfigRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppConfigRes clone() => AppConfigRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppConfigRes copyWith(void Function(AppConfigRes) updates) => super.copyWith((message) => updates(message as AppConfigRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppConfigRes create() => AppConfigRes._();
  AppConfigRes createEmptyInstance() => create();
  static $pb.PbList<AppConfigRes> createRepeated() => $pb.PbList<AppConfigRes>();
  @$core.pragma('dart2js:noInline')
  static AppConfigRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppConfigRes>(create);
  static AppConfigRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conf => $_getSZ(0);
  @$pb.TagNumber(1)
  set conf($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConf() => $_has(0);
  @$pb.TagNumber(1)
  void clearConf() => clearField(1);

  @$pb.TagNumber(2)
  $1.Err get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Err v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => clearField(2);
  @$pb.TagNumber(2)
  $1.Err ensureErr() => $_ensure(1);
}

