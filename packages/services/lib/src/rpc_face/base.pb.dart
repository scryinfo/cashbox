//
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Err extends $pb.GeneratedMessage {
  factory Err() => create();
  Err._() : super();
  factory Err.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Err.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Err', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Err clone() => Err()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Err copyWith(void Function(Err) updates) => super.copyWith((message) => updates(message as Err)) as Err;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Err create() => Err._();
  Err createEmptyInstance() => create();
  static $pb.PbList<Err> createRepeated() => $pb.PbList<Err>();
  @$core.pragma('dart2js:noInline')
  static Err getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Err>(create);
  static Err? _defaultInstance;

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
  factory Pair() => create();
  Pair._() : super();
  factory Pair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Pair', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Key', protoName: 'Key')
    ..aOS(2, _omitFieldNames ? '' : 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pair clone() => Pair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pair copyWith(void Function(Pair) updates) => super.copyWith((message) => updates(message as Pair)) as Pair;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Pair create() => Pair._();
  Pair createEmptyInstance() => create();
  static $pb.PbList<Pair> createRepeated() => $pb.PbList<Pair>();
  @$core.pragma('dart2js:noInline')
  static Pair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pair>(create);
  static Pair? _defaultInstance;

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
  factory RpcModelBase() => create();
  RpcModelBase._() : super();
  factory RpcModelBase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcModelBase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RpcModelBase', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Id', protoName: 'Id')
    ..aInt64(2, _omitFieldNames ? '' : 'UpdateTime', protoName: 'UpdateTime')
    ..aInt64(3, _omitFieldNames ? '' : 'CreateTime', protoName: 'CreateTime')
    ..aInt64(4, _omitFieldNames ? '' : 'OptimisticLockVersion', protoName: 'OptimisticLockVersion')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RpcModelBase clone() => RpcModelBase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RpcModelBase copyWith(void Function(RpcModelBase) updates) => super.copyWith((message) => updates(message as RpcModelBase)) as RpcModelBase;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RpcModelBase create() => RpcModelBase._();
  RpcModelBase createEmptyInstance() => create();
  static $pb.PbList<RpcModelBase> createRepeated() => $pb.PbList<RpcModelBase>();
  @$core.pragma('dart2js:noInline')
  static RpcModelBase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcModelBase>(create);
  static RpcModelBase? _defaultInstance;

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
  factory LanguageValue() => create();
  LanguageValue._() : super();
  factory LanguageValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LanguageValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LanguageValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'LanguageId', protoName: 'LanguageId')
    ..aOS(2, _omitFieldNames ? '' : 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LanguageValue clone() => LanguageValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LanguageValue copyWith(void Function(LanguageValue) updates) => super.copyWith((message) => updates(message as LanguageValue)) as LanguageValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LanguageValue create() => LanguageValue._();
  LanguageValue createEmptyInstance() => create();
  static $pb.PbList<LanguageValue> createRepeated() => $pb.PbList<LanguageValue>();
  @$core.pragma('dart2js:noInline')
  static LanguageValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LanguageValue>(create);
  static LanguageValue? _defaultInstance;

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
  factory Languages() => create();
  Languages._() : super();
  factory Languages.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Languages.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Languages', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'DefaultValue', protoName: 'DefaultValue')
    ..pc<LanguageValue>(2, _omitFieldNames ? '' : 'Values', $pb.PbFieldType.PM, protoName: 'Values', subBuilder: LanguageValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Languages clone() => Languages()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Languages copyWith(void Function(Languages) updates) => super.copyWith((message) => updates(message as Languages)) as Languages;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Languages create() => Languages._();
  Languages createEmptyInstance() => create();
  static $pb.PbList<Languages> createRepeated() => $pb.PbList<Languages>();
  @$core.pragma('dart2js:noInline')
  static Languages getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Languages>(create);
  static Languages? _defaultInstance;

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
  factory PageReq() => create();
  PageReq._() : super();
  factory PageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PageReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PageReq clone() => PageReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PageReq copyWith(void Function(PageReq) updates) => super.copyWith((message) => updates(message as PageReq)) as PageReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PageReq create() => PageReq._();
  PageReq createEmptyInstance() => create();
  static $pb.PbList<PageReq> createRepeated() => $pb.PbList<PageReq>();
  @$core.pragma('dart2js:noInline')
  static PageReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageReq>(create);
  static PageReq? _defaultInstance;

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
  factory PageRes() => create();
  PageRes._() : super();
  factory PageRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PageRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PageRes clone() => PageRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PageRes copyWith(void Function(PageRes) updates) => super.copyWith((message) => updates(message as PageRes)) as PageRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PageRes create() => PageRes._();
  PageRes createEmptyInstance() => create();
  static $pb.PbList<PageRes> createRepeated() => $pb.PbList<PageRes>();
  @$core.pragma('dart2js:noInline')
  static PageRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageRes>(create);
  static PageRes? _defaultInstance;

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
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class ErrRes extends $pb.GeneratedMessage {
  factory ErrRes() => create();
  ErrRes._() : super();
  factory ErrRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ErrRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, _omitFieldNames ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ErrRes clone() => ErrRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ErrRes copyWith(void Function(ErrRes) updates) => super.copyWith((message) => updates(message as ErrRes)) as ErrRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrRes create() => ErrRes._();
  ErrRes createEmptyInstance() => create();
  static $pb.PbList<ErrRes> createRepeated() => $pb.PbList<ErrRes>();
  @$core.pragma('dart2js:noInline')
  static ErrRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrRes>(create);
  static ErrRes? _defaultInstance;

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
  factory DeleteReq() => create();
  DeleteReq._() : super();
  factory DeleteReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'ids')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteReq clone() => DeleteReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteReq copyWith(void Function(DeleteReq) updates) => super.copyWith((message) => updates(message as DeleteReq)) as DeleteReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteReq create() => DeleteReq._();
  DeleteReq createEmptyInstance() => create();
  static $pb.PbList<DeleteReq> createRepeated() => $pb.PbList<DeleteReq>();
  @$core.pragma('dart2js:noInline')
  static DeleteReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteReq>(create);
  static DeleteReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get ids => $_getList(0);
}

class DeleteRes extends $pb.GeneratedMessage {
  factory DeleteRes() => create();
  DeleteRes._() : super();
  factory DeleteRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, _omitFieldNames ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRes clone() => DeleteRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRes copyWith(void Function(DeleteRes) updates) => super.copyWith((message) => updates(message as DeleteRes)) as DeleteRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRes create() => DeleteRes._();
  DeleteRes createEmptyInstance() => create();
  static $pb.PbList<DeleteRes> createRepeated() => $pb.PbList<DeleteRes>();
  @$core.pragma('dart2js:noInline')
  static DeleteRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRes>(create);
  static DeleteRes? _defaultInstance;

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
  factory RecordStatusReq() => create();
  RecordStatusReq._() : super();
  factory RecordStatusReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordStatusReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'ids')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordStatusReq clone() => RecordStatusReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordStatusReq copyWith(void Function(RecordStatusReq) updates) => super.copyWith((message) => updates(message as RecordStatusReq)) as RecordStatusReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordStatusReq create() => RecordStatusReq._();
  RecordStatusReq createEmptyInstance() => create();
  static $pb.PbList<RecordStatusReq> createRepeated() => $pb.PbList<RecordStatusReq>();
  @$core.pragma('dart2js:noInline')
  static RecordStatusReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordStatusReq>(create);
  static RecordStatusReq? _defaultInstance;

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
  factory RecordStatusRes() => create();
  RecordStatusRes._() : super();
  factory RecordStatusRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordStatusRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, _omitFieldNames ? '' : 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordStatusRes clone() => RecordStatusRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordStatusRes copyWith(void Function(RecordStatusRes) updates) => super.copyWith((message) => updates(message as RecordStatusRes)) as RecordStatusRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordStatusRes create() => RecordStatusRes._();
  RecordStatusRes createEmptyInstance() => create();
  static $pb.PbList<RecordStatusRes> createRepeated() => $pb.PbList<RecordStatusRes>();
  @$core.pragma('dart2js:noInline')
  static RecordStatusRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordStatusRes>(create);
  static RecordStatusRes? _defaultInstance;

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

class QueryReq extends $pb.GeneratedMessage {
  factory QueryReq() => create();
  QueryReq._() : super();
  factory QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<PageReq>(1, _omitFieldNames ? '' : 'page', subBuilder: PageReq.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReq clone() => QueryReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReq copyWith(void Function(QueryReq) updates) => super.copyWith((message) => updates(message as QueryReq)) as QueryReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReq create() => QueryReq._();
  QueryReq createEmptyInstance() => create();
  static $pb.PbList<QueryReq> createRepeated() => $pb.PbList<QueryReq>();
  @$core.pragma('dart2js:noInline')
  static QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReq>(create);
  static QueryReq? _defaultInstance;

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
  factory GetByIdReq() => create();
  GetByIdReq._() : super();
  factory GetByIdReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetByIdReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetByIdReq clone() => GetByIdReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetByIdReq copyWith(void Function(GetByIdReq) updates) => super.copyWith((message) => updates(message as GetByIdReq)) as GetByIdReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByIdReq create() => GetByIdReq._();
  GetByIdReq createEmptyInstance() => create();
  static $pb.PbList<GetByIdReq> createRepeated() => $pb.PbList<GetByIdReq>();
  @$core.pragma('dart2js:noInline')
  static GetByIdReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetByIdReq>(create);
  static GetByIdReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class AppKey extends $pb.GeneratedMessage {
  factory AppKey() => create();
  AppKey._() : super();
  factory AppKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AppKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey', protoName: 'pubKey')
    ..aOS(2, _omitFieldNames ? '' : 'priKey', protoName: 'priKey')
    ..aOS(3, _omitFieldNames ? '' : 'keyType', protoName: 'keyType')
    ..aOS(4, _omitFieldNames ? '' : 'keyAuthType', protoName: 'keyAuthType')
    ..aInt64(5, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppKey clone() => AppKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppKey copyWith(void Function(AppKey) updates) => super.copyWith((message) => updates(message as AppKey)) as AppKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppKey create() => AppKey._();
  AppKey createEmptyInstance() => create();
  static $pb.PbList<AppKey> createRepeated() => $pb.PbList<AppKey>();
  @$core.pragma('dart2js:noInline')
  static AppKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppKey>(create);
  static AppKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get priKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set priKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPriKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get keyType => $_getSZ(2);
  @$pb.TagNumber(3)
  set keyType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasKeyType() => $_has(2);
  @$pb.TagNumber(3)
  void clearKeyType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get keyAuthType => $_getSZ(3);
  @$pb.TagNumber(4)
  set keyAuthType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasKeyAuthType() => $_has(3);
  @$pb.TagNumber(4)
  void clearKeyAuthType() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get value => $_getI64(4);
  @$pb.TagNumber(5)
  set value($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearValue() => clearField(5);
}

class BasicClientReq extends $pb.GeneratedMessage {
  factory BasicClientReq() => create();
  BasicClientReq._() : super();
  factory BasicClientReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BasicClientReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BasicClientReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..aOS(2, _omitFieldNames ? '' : 'deviceId', protoName: 'deviceId')
    ..aOS(3, _omitFieldNames ? '' : 'cashboxType', protoName: 'cashboxType')
    ..aOS(4, _omitFieldNames ? '' : 'cashboxVersion', protoName: 'cashboxVersion')
    ..aOS(5, _omitFieldNames ? '' : 'platformType', protoName: 'platformType')
    ..aInt64(6, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BasicClientReq clone() => BasicClientReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BasicClientReq copyWith(void Function(BasicClientReq) updates) => super.copyWith((message) => updates(message as BasicClientReq)) as BasicClientReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BasicClientReq create() => BasicClientReq._();
  BasicClientReq createEmptyInstance() => create();
  static $pb.PbList<BasicClientReq> createRepeated() => $pb.PbList<BasicClientReq>();
  @$core.pragma('dart2js:noInline')
  static BasicClientReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasicClientReq>(create);
  static BasicClientReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cashboxType => $_getSZ(2);
  @$pb.TagNumber(3)
  set cashboxType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCashboxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCashboxType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cashboxVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set cashboxVersion($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCashboxVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearCashboxVersion() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get platformType => $_getSZ(4);
  @$pb.TagNumber(5)
  set platformType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlatformType() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlatformType() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get timestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set timestamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
