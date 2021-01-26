///
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Err extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Err', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  Err._() : super();
  factory Err({
    $fixnum.Int64 code,
    $core.String message,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory Err.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Err.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Err clone() => Err()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Err copyWith(void Function(Err) updates) => super.copyWith((message) => updates(message as Err)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Err create() => Err._();
  Err createEmptyInstance() => create();
  static $pb.PbList<Err> createRepeated() => $pb.PbList<Err>();
  @$core.pragma('dart2js:noInline')
  static Err getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Err>(create);
  static Err _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get code => $_getI64(0);
  @$pb.TagNumber(1)
  set code($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class Pair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Pair', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Key', protoName: 'Key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  Pair._() : super();
  factory Pair({
    $core.String key,
    $core.String value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory Pair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pair clone() => Pair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pair copyWith(void Function(Pair) updates) => super.copyWith((message) => updates(message as Pair)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Pair create() => Pair._();
  Pair createEmptyInstance() => create();
  static $pb.PbList<Pair> createRepeated() => $pb.PbList<Pair>();
  @$core.pragma('dart2js:noInline')
  static Pair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pair>(create);
  static Pair _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class RpcModelBase extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RpcModelBase', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UpdateTime', protoName: 'UpdateTime')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CreateTime', protoName: 'CreateTime')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OptimisticLockVersion', protoName: 'OptimisticLockVersion')
    ..hasRequiredFields = false
  ;

  RpcModelBase._() : super();
  factory RpcModelBase({
    $core.String id,
    $fixnum.Int64 updateTime,
    $fixnum.Int64 createTime,
    $fixnum.Int64 optimisticLockVersion,
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
    return _result;
  }
  factory RpcModelBase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcModelBase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RpcModelBase clone() => RpcModelBase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RpcModelBase copyWith(void Function(RpcModelBase) updates) => super.copyWith((message) => updates(message as RpcModelBase)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RpcModelBase create() => RpcModelBase._();
  RpcModelBase createEmptyInstance() => create();
  static $pb.PbList<RpcModelBase> createRepeated() => $pb.PbList<RpcModelBase>();
  @$core.pragma('dart2js:noInline')
  static RpcModelBase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcModelBase>(create);
  static RpcModelBase _defaultInstance;

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
}

class LanguageValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LanguageValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LanguageId', protoName: 'LanguageId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  LanguageValue._() : super();
  factory LanguageValue({
    $core.String languageId,
    $core.String value,
  }) {
    final _result = create();
    if (languageId != null) {
      _result.languageId = languageId;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory LanguageValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LanguageValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LanguageValue clone() => LanguageValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LanguageValue copyWith(void Function(LanguageValue) updates) => super.copyWith((message) => updates(message as LanguageValue)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LanguageValue create() => LanguageValue._();
  LanguageValue createEmptyInstance() => create();
  static $pb.PbList<LanguageValue> createRepeated() => $pb.PbList<LanguageValue>();
  @$core.pragma('dart2js:noInline')
  static LanguageValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LanguageValue>(create);
  static LanguageValue _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get languageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set languageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLanguageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLanguageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class Languages extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Languages', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DefaultValue', protoName: 'DefaultValue')
    ..pc<LanguageValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Values', $pb.PbFieldType.PM, protoName: 'Values', subBuilder: LanguageValue.create)
    ..hasRequiredFields = false
  ;

  Languages._() : super();
  factory Languages({
    $core.String defaultValue,
    $core.Iterable<LanguageValue> values,
  }) {
    final _result = create();
    if (defaultValue != null) {
      _result.defaultValue = defaultValue;
    }
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory Languages.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Languages.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Languages clone() => Languages()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Languages copyWith(void Function(Languages) updates) => super.copyWith((message) => updates(message as Languages)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Languages create() => Languages._();
  Languages createEmptyInstance() => create();
  static $pb.PbList<Languages> createRepeated() => $pb.PbList<Languages>();
  @$core.pragma('dart2js:noInline')
  static Languages getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Languages>(create);
  static Languages _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get defaultValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set defaultValue($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDefaultValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<LanguageValue> get values => $_getList(1);
}

class PageReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PageReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PageReq._() : super();
  factory PageReq({
    $core.int pageSize,
    $core.int page,
  }) {
    final _result = create();
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (page != null) {
      _result.page = page;
    }
    return _result;
  }
  factory PageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PageReq clone() => PageReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PageReq copyWith(void Function(PageReq) updates) => super.copyWith((message) => updates(message as PageReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PageReq create() => PageReq._();
  PageReq createEmptyInstance() => create();
  static $pb.PbList<PageReq> createRepeated() => $pb.PbList<PageReq>();
  @$core.pragma('dart2js:noInline')
  static PageReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageReq>(create);
  static PageReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
}

class PageRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PageRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PageRes._() : super();
  factory PageRes({
    $core.int pageSize,
    $core.int page,
    $core.int total,
  }) {
    final _result = create();
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (page != null) {
      _result.page = page;
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory PageRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PageRes clone() => PageRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PageRes copyWith(void Function(PageRes) updates) => super.copyWith((message) => updates(message as PageRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PageRes create() => PageRes._();
  PageRes createEmptyInstance() => create();
  static $pb.PbList<PageRes> createRepeated() => $pb.PbList<PageRes>();
  @$core.pragma('dart2js:noInline')
  static PageRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageRes>(create);
  static PageRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => clearField(3);
}

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Empty', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty _defaultInstance;
}

class ErrRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ErrRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  ErrRes._() : super();
  factory ErrRes({
    Err err,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory ErrRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ErrRes clone() => ErrRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ErrRes copyWith(void Function(ErrRes) updates) => super.copyWith((message) => updates(message as ErrRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrRes create() => ErrRes._();
  ErrRes createEmptyInstance() => create();
  static $pb.PbList<ErrRes> createRepeated() => $pb.PbList<ErrRes>();
  @$core.pragma('dart2js:noInline')
  static ErrRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrRes>(create);
  static ErrRes _defaultInstance;

  @$pb.TagNumber(1)
  Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err(Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  Err ensureErr() => $_ensure(0);
}

class DeleteReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ids')
    ..hasRequiredFields = false
  ;

  DeleteReq._() : super();
  factory DeleteReq({
    $core.Iterable<$core.String> ids,
  }) {
    final _result = create();
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    return _result;
  }
  factory DeleteReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteReq clone() => DeleteReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteReq copyWith(void Function(DeleteReq) updates) => super.copyWith((message) => updates(message as DeleteReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteReq create() => DeleteReq._();
  DeleteReq createEmptyInstance() => create();
  static $pb.PbList<DeleteReq> createRepeated() => $pb.PbList<DeleteReq>();
  @$core.pragma('dart2js:noInline')
  static DeleteReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteReq>(create);
  static DeleteReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get ids => $_getList(0);
}

class DeleteRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  DeleteRes._() : super();
  factory DeleteRes({
    Err err,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory DeleteRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRes clone() => DeleteRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRes copyWith(void Function(DeleteRes) updates) => super.copyWith((message) => updates(message as DeleteRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteRes create() => DeleteRes._();
  DeleteRes createEmptyInstance() => create();
  static $pb.PbList<DeleteRes> createRepeated() => $pb.PbList<DeleteRes>();
  @$core.pragma('dart2js:noInline')
  static DeleteRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRes>(create);
  static DeleteRes _defaultInstance;

  @$pb.TagNumber(1)
  Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err(Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  Err ensureErr() => $_ensure(0);
}

class RecordStatusReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordStatusReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ids')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  RecordStatusReq._() : super();
  factory RecordStatusReq({
    $core.Iterable<$core.String> ids,
    $core.String status,
  }) {
    final _result = create();
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory RecordStatusReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordStatusReq clone() => RecordStatusReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordStatusReq copyWith(void Function(RecordStatusReq) updates) => super.copyWith((message) => updates(message as RecordStatusReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordStatusReq create() => RecordStatusReq._();
  RecordStatusReq createEmptyInstance() => create();
  static $pb.PbList<RecordStatusReq> createRepeated() => $pb.PbList<RecordStatusReq>();
  @$core.pragma('dart2js:noInline')
  static RecordStatusReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordStatusReq>(create);
  static RecordStatusReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get ids => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

class RecordStatusRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordStatusRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  RecordStatusRes._() : super();
  factory RecordStatusRes({
    Err err,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory RecordStatusRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordStatusRes clone() => RecordStatusRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordStatusRes copyWith(void Function(RecordStatusRes) updates) => super.copyWith((message) => updates(message as RecordStatusRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordStatusRes create() => RecordStatusRes._();
  RecordStatusRes createEmptyInstance() => create();
  static $pb.PbList<RecordStatusRes> createRepeated() => $pb.PbList<RecordStatusRes>();
  @$core.pragma('dart2js:noInline')
  static RecordStatusRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordStatusRes>(create);
  static RecordStatusRes _defaultInstance;

  @$pb.TagNumber(1)
  Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err(Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  Err ensureErr() => $_ensure(0);
}

class ListReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<PageReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', subBuilder: PageReq.create)
    ..hasRequiredFields = false
  ;

  ListReq._() : super();
  factory ListReq({
    PageReq page,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    return _result;
  }
  factory ListReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListReq clone() => ListReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListReq copyWith(void Function(ListReq) updates) => super.copyWith((message) => updates(message as ListReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListReq create() => ListReq._();
  ListReq createEmptyInstance() => create();
  static $pb.PbList<ListReq> createRepeated() => $pb.PbList<ListReq>();
  @$core.pragma('dart2js:noInline')
  static ListReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListReq>(create);
  static ListReq _defaultInstance;

  @$pb.TagNumber(1)
  PageReq get page => $_getN(0);
  @$pb.TagNumber(1)
  set page(PageReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);
  @$pb.TagNumber(1)
  PageReq ensurePage() => $_ensure(0);
}

class GetByIdReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetByIdReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetByIdReq._() : super();
  factory GetByIdReq({
    $core.String id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetByIdReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetByIdReq clone() => GetByIdReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetByIdReq copyWith(void Function(GetByIdReq) updates) => super.copyWith((message) => updates(message as GetByIdReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetByIdReq create() => GetByIdReq._();
  GetByIdReq createEmptyInstance() => create();
  static $pb.PbList<GetByIdReq> createRepeated() => $pb.PbList<GetByIdReq>();
  @$core.pragma('dart2js:noInline')
  static GetByIdReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetByIdReq>(create);
  static GetByIdReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

