///
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Err extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Err', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aInt64(1, 'code')
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  Err._() : super();
  factory Err() => create();
  factory Err.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Err.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Err clone() => Err()..mergeFromMessage(this);
  Err copyWith(void Function(Err) updates) => super.copyWith((message) => updates(message as Err));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Pair', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'Key', protoName: 'Key')
    ..aOS(2, 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  Pair._() : super();
  factory Pair() => create();
  factory Pair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Pair clone() => Pair()..mergeFromMessage(this);
  Pair copyWith(void Function(Pair) updates) => super.copyWith((message) => updates(message as Pair));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RpcModelBase', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'Id', protoName: 'Id')
    ..aInt64(2, 'UpdateTime', protoName: 'UpdateTime')
    ..aInt64(3, 'CreateTime', protoName: 'CreateTime')
    ..aInt64(4, 'OptimisticLockVersion', protoName: 'OptimisticLockVersion')
    ..hasRequiredFields = false
  ;

  RpcModelBase._() : super();
  factory RpcModelBase() => create();
  factory RpcModelBase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcModelBase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RpcModelBase clone() => RpcModelBase()..mergeFromMessage(this);
  RpcModelBase copyWith(void Function(RpcModelBase) updates) => super.copyWith((message) => updates(message as RpcModelBase));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LanguageValue', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'LanguageId', protoName: 'LanguageId')
    ..aOS(2, 'Value', protoName: 'Value')
    ..hasRequiredFields = false
  ;

  LanguageValue._() : super();
  factory LanguageValue() => create();
  factory LanguageValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LanguageValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LanguageValue clone() => LanguageValue()..mergeFromMessage(this);
  LanguageValue copyWith(void Function(LanguageValue) updates) => super.copyWith((message) => updates(message as LanguageValue));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Languages', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'DefaultValue', protoName: 'DefaultValue')
    ..pc<LanguageValue>(2, 'Values', $pb.PbFieldType.PM, protoName: 'Values', subBuilder: LanguageValue.create)
    ..hasRequiredFields = false
  ;

  Languages._() : super();
  factory Languages() => create();
  factory Languages.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Languages.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Languages clone() => Languages()..mergeFromMessage(this);
  Languages copyWith(void Function(Languages) updates) => super.copyWith((message) => updates(message as Languages));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PageReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PageReq._() : super();
  factory PageReq() => create();
  factory PageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PageReq clone() => PageReq()..mergeFromMessage(this);
  PageReq copyWith(void Function(PageReq) updates) => super.copyWith((message) => updates(message as PageReq));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PageRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..a<$core.int>(1, 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..a<$core.int>(2, 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PageRes._() : super();
  factory PageRes() => create();
  factory PageRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PageRes clone() => PageRes()..mergeFromMessage(this);
  PageRes copyWith(void Function(PageRes) updates) => super.copyWith((message) => updates(message as PageRes));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Empty', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Empty clone() => Empty()..mergeFromMessage(this);
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  ErrRes._() : super();
  factory ErrRes() => create();
  factory ErrRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ErrRes clone() => ErrRes()..mergeFromMessage(this);
  ErrRes copyWith(void Function(ErrRes) updates) => super.copyWith((message) => updates(message as ErrRes));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeleteReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..pPS(1, 'ids')
    ..hasRequiredFields = false
  ;

  DeleteReq._() : super();
  factory DeleteReq() => create();
  factory DeleteReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DeleteReq clone() => DeleteReq()..mergeFromMessage(this);
  DeleteReq copyWith(void Function(DeleteReq) updates) => super.copyWith((message) => updates(message as DeleteReq));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeleteRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  DeleteRes._() : super();
  factory DeleteRes() => create();
  factory DeleteRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DeleteRes clone() => DeleteRes()..mergeFromMessage(this);
  DeleteRes copyWith(void Function(DeleteRes) updates) => super.copyWith((message) => updates(message as DeleteRes));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RecordStatusReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..pPS(1, 'ids')
    ..aOS(2, 'status')
    ..hasRequiredFields = false
  ;

  RecordStatusReq._() : super();
  factory RecordStatusReq() => create();
  factory RecordStatusReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RecordStatusReq clone() => RecordStatusReq()..mergeFromMessage(this);
  RecordStatusReq copyWith(void Function(RecordStatusReq) updates) => super.copyWith((message) => updates(message as RecordStatusReq));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RecordStatusRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<Err>(1, 'err', subBuilder: Err.create)
    ..hasRequiredFields = false
  ;

  RecordStatusRes._() : super();
  factory RecordStatusRes() => create();
  factory RecordStatusRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordStatusRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RecordStatusRes clone() => RecordStatusRes()..mergeFromMessage(this);
  RecordStatusRes copyWith(void Function(RecordStatusRes) updates) => super.copyWith((message) => updates(message as RecordStatusRes));
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

class QueryReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QueryReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<PageReq>(1, 'page', subBuilder: PageReq.create)
    ..hasRequiredFields = false
  ;

  QueryReq._() : super();
  factory QueryReq() => create();
  factory QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  QueryReq clone() => QueryReq()..mergeFromMessage(this);
  QueryReq copyWith(void Function(QueryReq) updates) => super.copyWith((message) => updates(message as QueryReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryReq create() => QueryReq._();
  QueryReq createEmptyInstance() => create();
  static $pb.PbList<QueryReq> createRepeated() => $pb.PbList<QueryReq>();
  @$core.pragma('dart2js:noInline')
  static QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReq>(create);
  static QueryReq _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetByIdReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  GetByIdReq._() : super();
  factory GetByIdReq() => create();
  factory GetByIdReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetByIdReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetByIdReq clone() => GetByIdReq()..mergeFromMessage(this);
  GetByIdReq copyWith(void Function(GetByIdReq) updates) => super.copyWith((message) => updates(message as GetByIdReq));
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

class AppKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AppKey', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'pubKey', protoName: 'pubKey')
    ..aOS(2, 'priKey', protoName: 'priKey')
    ..aOS(3, 'keyType', protoName: 'keyType')
    ..aOS(4, 'keyAuthType', protoName: 'keyAuthType')
    ..aInt64(5, 'value')
    ..hasRequiredFields = false
  ;

  AppKey._() : super();
  factory AppKey() => create();
  factory AppKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AppKey clone() => AppKey()..mergeFromMessage(this);
  AppKey copyWith(void Function(AppKey) updates) => super.copyWith((message) => updates(message as AppKey));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppKey create() => AppKey._();
  AppKey createEmptyInstance() => create();
  static $pb.PbList<AppKey> createRepeated() => $pb.PbList<AppKey>();
  @$core.pragma('dart2js:noInline')
  static AppKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppKey>(create);
  static AppKey _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BasicClientReq', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOS(1, 'signature')
    ..aOS(2, 'deviceId', protoName: 'deviceId')
    ..aOS(3, 'cashboxType', protoName: 'cashboxType')
    ..aOS(4, 'cashboxVersion', protoName: 'cashboxVersion')
    ..aOS(5, 'platformType', protoName: 'platformType')
    ..aInt64(6, 'timestamp')
    ..hasRequiredFields = false
  ;

  BasicClientReq._() : super();
  factory BasicClientReq() => create();
  factory BasicClientReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BasicClientReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BasicClientReq clone() => BasicClientReq()..mergeFromMessage(this);
  BasicClientReq copyWith(void Function(BasicClientReq) updates) => super.copyWith((message) => updates(message as BasicClientReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BasicClientReq create() => BasicClientReq._();
  BasicClientReq createEmptyInstance() => create();
  static $pb.PbList<BasicClientReq> createRepeated() => $pb.PbList<BasicClientReq>();
  @$core.pragma('dart2js:noInline')
  static BasicClientReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BasicClientReq>(create);
  static BasicClientReq _defaultInstance;

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

