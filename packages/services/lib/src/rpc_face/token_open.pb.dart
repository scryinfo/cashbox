//
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class TokenSharedOpen extends $pb.GeneratedMessage {
  factory TokenSharedOpen() => create();
  TokenSharedOpen._() : super();
  factory TokenSharedOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenSharedOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TokenSharedOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Symbol', protoName: 'Symbol')
    ..aOS(2, _omitFieldNames ? '' : 'Name', protoName: 'Name')
    ..aOS(3, _omitFieldNames ? '' : 'Publisher', protoName: 'Publisher')
    ..aOS(4, _omitFieldNames ? '' : 'Project', protoName: 'Project')
    ..aOS(5, _omitFieldNames ? '' : 'LogoUrl', protoName: 'LogoUrl')
    ..aOS(6, _omitFieldNames ? '' : 'LogoBytes', protoName: 'LogoBytes')
    ..aOS(7, _omitFieldNames ? '' : 'ChainType', protoName: 'ChainType')
    ..aOS(8, _omitFieldNames ? '' : 'Mark', protoName: 'Mark')
    ..aOS(9, _omitFieldNames ? '' : 'TokenId', protoName: 'TokenId')
    ..aOS(10, _omitFieldNames ? '' : 'NetType', protoName: 'NetType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenSharedOpen clone() => TokenSharedOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenSharedOpen copyWith(void Function(TokenSharedOpen) updates) => super.copyWith((message) => updates(message as TokenSharedOpen)) as TokenSharedOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenSharedOpen create() => TokenSharedOpen._();
  TokenSharedOpen createEmptyInstance() => create();
  static $pb.PbList<TokenSharedOpen> createRepeated() => $pb.PbList<TokenSharedOpen>();
  @$core.pragma('dart2js:noInline')
  static TokenSharedOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenSharedOpen>(create);
  static TokenSharedOpen? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get publisher => $_getSZ(2);
  @$pb.TagNumber(3)
  set publisher($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublisher() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublisher() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get project => $_getSZ(3);
  @$pb.TagNumber(4)
  set project($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProject() => $_has(3);
  @$pb.TagNumber(4)
  void clearProject() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get logoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set logoUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLogoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogoUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get logoBytes => $_getSZ(5);
  @$pb.TagNumber(6)
  set logoBytes($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLogoBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearLogoBytes() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get chainType => $_getSZ(6);
  @$pb.TagNumber(7)
  set chainType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasChainType() => $_has(6);
  @$pb.TagNumber(7)
  void clearChainType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get mark => $_getSZ(7);
  @$pb.TagNumber(8)
  set mark($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMark() => $_has(7);
  @$pb.TagNumber(8)
  void clearMark() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get tokenId => $_getSZ(8);
  @$pb.TagNumber(9)
  set tokenId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTokenId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTokenId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get netType => $_getSZ(9);
  @$pb.TagNumber(10)
  set netType($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNetType() => $_has(9);
  @$pb.TagNumber(10)
  void clearNetType() => clearField(10);
}

class EthTokenOpen_Token extends $pb.GeneratedMessage {
  factory EthTokenOpen_Token() => create();
  EthTokenOpen_Token._() : super();
  factory EthTokenOpen_Token.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_Token.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EthTokenOpen.Token', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Id', protoName: 'Id')
    ..aOS(2, _omitFieldNames ? '' : 'TokenShardId', protoName: 'TokenShardId')
    ..aOM<TokenSharedOpen>(3, _omitFieldNames ? '' : 'TokenShared', protoName: 'TokenShared', subBuilder: TokenSharedOpen.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'Decimal', $pb.PbFieldType.O3, protoName: 'Decimal')
    ..aInt64(5, _omitFieldNames ? '' : 'GasLimit', protoName: 'GasLimit')
    ..aOS(6, _omitFieldNames ? '' : 'Contract', protoName: 'Contract')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'Position', $pb.PbFieldType.OD, protoName: 'Position')
    ..aInt64(8, _omitFieldNames ? '' : 'GasPrice', protoName: 'GasPrice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_Token clone() => EthTokenOpen_Token()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_Token copyWith(void Function(EthTokenOpen_Token) updates) => super.copyWith((message) => updates(message as EthTokenOpen_Token)) as EthTokenOpen_Token;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_Token create() => EthTokenOpen_Token._();
  EthTokenOpen_Token createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_Token> createRepeated() => $pb.PbList<EthTokenOpen_Token>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_Token getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_Token>(create);
  static EthTokenOpen_Token? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tokenShardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set tokenShardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTokenShardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokenShardId() => clearField(2);

  @$pb.TagNumber(3)
  TokenSharedOpen get tokenShared => $_getN(2);
  @$pb.TagNumber(3)
  set tokenShared(TokenSharedOpen v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTokenShared() => $_has(2);
  @$pb.TagNumber(3)
  void clearTokenShared() => clearField(3);
  @$pb.TagNumber(3)
  TokenSharedOpen ensureTokenShared() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get decimal => $_getIZ(3);
  @$pb.TagNumber(4)
  set decimal($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDecimal() => $_has(3);
  @$pb.TagNumber(4)
  void clearDecimal() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get gasLimit => $_getI64(4);
  @$pb.TagNumber(5)
  set gasLimit($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearGasLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get contract => $_getSZ(5);
  @$pb.TagNumber(6)
  set contract($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasContract() => $_has(5);
  @$pb.TagNumber(6)
  void clearContract() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get position => $_getN(6);
  @$pb.TagNumber(7)
  set position($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPosition() => $_has(6);
  @$pb.TagNumber(7)
  void clearPosition() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get gasPrice => $_getI64(7);
  @$pb.TagNumber(8)
  set gasPrice($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearGasPrice() => clearField(8);
}

class EthTokenOpen_QueryReq extends $pb.GeneratedMessage {
  factory EthTokenOpen_QueryReq() => create();
  EthTokenOpen_QueryReq._() : super();
  factory EthTokenOpen_QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EthTokenOpen.QueryReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.BasicClientReq>(1, _omitFieldNames ? '' : 'info', subBuilder: $0.BasicClientReq.create)
    ..aOB(2, _omitFieldNames ? '' : 'isDefault', protoName: 'isDefault')
    ..aOM<$0.PageReq>(3, _omitFieldNames ? '' : 'page', subBuilder: $0.PageReq.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryReq clone() => EthTokenOpen_QueryReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryReq copyWith(void Function(EthTokenOpen_QueryReq) updates) => super.copyWith((message) => updates(message as EthTokenOpen_QueryReq)) as EthTokenOpen_QueryReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryReq create() => EthTokenOpen_QueryReq._();
  EthTokenOpen_QueryReq createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_QueryReq> createRepeated() => $pb.PbList<EthTokenOpen_QueryReq>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_QueryReq>(create);
  static EthTokenOpen_QueryReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.BasicClientReq get info => $_getN(0);
  @$pb.TagNumber(1)
  set info($0.BasicClientReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => clearField(1);
  @$pb.TagNumber(1)
  $0.BasicClientReq ensureInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isDefault => $_getBF(1);
  @$pb.TagNumber(2)
  set isDefault($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsDefault() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDefault() => clearField(2);

  @$pb.TagNumber(3)
  $0.PageReq get page => $_getN(2);
  @$pb.TagNumber(3)
  set page($0.PageReq v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);
  @$pb.TagNumber(3)
  $0.PageReq ensurePage() => $_ensure(2);
}

class EthTokenOpen_QueryRes extends $pb.GeneratedMessage {
  factory EthTokenOpen_QueryRes() => create();
  EthTokenOpen_QueryRes._() : super();
  factory EthTokenOpen_QueryRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_QueryRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EthTokenOpen.QueryRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pc<EthTokenOpen_Token>(1, _omitFieldNames ? '' : 'tokens', $pb.PbFieldType.PM, subBuilder: EthTokenOpen_Token.create)
    ..aOM<$0.PageRes>(2, _omitFieldNames ? '' : 'page', subBuilder: $0.PageRes.create)
    ..aOM<$0.Err>(3, _omitFieldNames ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryRes clone() => EthTokenOpen_QueryRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryRes copyWith(void Function(EthTokenOpen_QueryRes) updates) => super.copyWith((message) => updates(message as EthTokenOpen_QueryRes)) as EthTokenOpen_QueryRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryRes create() => EthTokenOpen_QueryRes._();
  EthTokenOpen_QueryRes createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_QueryRes> createRepeated() => $pb.PbList<EthTokenOpen_QueryRes>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_QueryRes>(create);
  static EthTokenOpen_QueryRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EthTokenOpen_Token> get tokens => $_getList(0);

  @$pb.TagNumber(2)
  $0.PageRes get page => $_getN(1);
  @$pb.TagNumber(2)
  set page($0.PageRes v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
  @$pb.TagNumber(2)
  $0.PageRes ensurePage() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Err get err => $_getN(2);
  @$pb.TagNumber(3)
  set err($0.Err v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErr() => $_has(2);
  @$pb.TagNumber(3)
  void clearErr() => clearField(3);
  @$pb.TagNumber(3)
  $0.Err ensureErr() => $_ensure(2);
}

class EthTokenOpen extends $pb.GeneratedMessage {
  factory EthTokenOpen() => create();
  EthTokenOpen._() : super();
  factory EthTokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EthTokenOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen clone() => EthTokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen copyWith(void Function(EthTokenOpen) updates) => super.copyWith((message) => updates(message as EthTokenOpen)) as EthTokenOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EthTokenOpen create() => EthTokenOpen._();
  EthTokenOpen createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen> createRepeated() => $pb.PbList<EthTokenOpen>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen>(create);
  static EthTokenOpen? _defaultInstance;
}

class EeeTokenOpen_Token extends $pb.GeneratedMessage {
  factory EeeTokenOpen_Token() => create();
  EeeTokenOpen_Token._() : super();
  factory EeeTokenOpen_Token.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EeeTokenOpen_Token.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EeeTokenOpen.Token', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Id', protoName: 'Id')
    ..aOS(2, _omitFieldNames ? '' : 'TokenShardId', protoName: 'TokenShardId')
    ..aOM<TokenSharedOpen>(3, _omitFieldNames ? '' : 'TokenShared', protoName: 'TokenShared', subBuilder: TokenSharedOpen.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'Decimal', $pb.PbFieldType.O3, protoName: 'Decimal')
    ..aInt64(5, _omitFieldNames ? '' : 'GasLimit', protoName: 'GasLimit')
    ..aOS(6, _omitFieldNames ? '' : 'Contract', protoName: 'Contract')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'Position', $pb.PbFieldType.OD, protoName: 'Position')
    ..aInt64(8, _omitFieldNames ? '' : 'GasPrice', protoName: 'GasPrice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_Token clone() => EeeTokenOpen_Token()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_Token copyWith(void Function(EeeTokenOpen_Token) updates) => super.copyWith((message) => updates(message as EeeTokenOpen_Token)) as EeeTokenOpen_Token;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_Token create() => EeeTokenOpen_Token._();
  EeeTokenOpen_Token createEmptyInstance() => create();
  static $pb.PbList<EeeTokenOpen_Token> createRepeated() => $pb.PbList<EeeTokenOpen_Token>();
  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_Token getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EeeTokenOpen_Token>(create);
  static EeeTokenOpen_Token? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tokenShardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set tokenShardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTokenShardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokenShardId() => clearField(2);

  @$pb.TagNumber(3)
  TokenSharedOpen get tokenShared => $_getN(2);
  @$pb.TagNumber(3)
  set tokenShared(TokenSharedOpen v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTokenShared() => $_has(2);
  @$pb.TagNumber(3)
  void clearTokenShared() => clearField(3);
  @$pb.TagNumber(3)
  TokenSharedOpen ensureTokenShared() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get decimal => $_getIZ(3);
  @$pb.TagNumber(4)
  set decimal($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDecimal() => $_has(3);
  @$pb.TagNumber(4)
  void clearDecimal() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get gasLimit => $_getI64(4);
  @$pb.TagNumber(5)
  set gasLimit($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearGasLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get contract => $_getSZ(5);
  @$pb.TagNumber(6)
  set contract($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasContract() => $_has(5);
  @$pb.TagNumber(6)
  void clearContract() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get position => $_getN(6);
  @$pb.TagNumber(7)
  set position($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPosition() => $_has(6);
  @$pb.TagNumber(7)
  void clearPosition() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get gasPrice => $_getI64(7);
  @$pb.TagNumber(8)
  set gasPrice($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearGasPrice() => clearField(8);
}

class EeeTokenOpen_QueryReq extends $pb.GeneratedMessage {
  factory EeeTokenOpen_QueryReq() => create();
  EeeTokenOpen_QueryReq._() : super();
  factory EeeTokenOpen_QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EeeTokenOpen_QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EeeTokenOpen.QueryReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.BasicClientReq>(1, _omitFieldNames ? '' : 'info', subBuilder: $0.BasicClientReq.create)
    ..aOB(2, _omitFieldNames ? '' : 'isDefault', protoName: 'isDefault')
    ..aOM<$0.PageReq>(3, _omitFieldNames ? '' : 'page', subBuilder: $0.PageReq.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_QueryReq clone() => EeeTokenOpen_QueryReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_QueryReq copyWith(void Function(EeeTokenOpen_QueryReq) updates) => super.copyWith((message) => updates(message as EeeTokenOpen_QueryReq)) as EeeTokenOpen_QueryReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_QueryReq create() => EeeTokenOpen_QueryReq._();
  EeeTokenOpen_QueryReq createEmptyInstance() => create();
  static $pb.PbList<EeeTokenOpen_QueryReq> createRepeated() => $pb.PbList<EeeTokenOpen_QueryReq>();
  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EeeTokenOpen_QueryReq>(create);
  static EeeTokenOpen_QueryReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.BasicClientReq get info => $_getN(0);
  @$pb.TagNumber(1)
  set info($0.BasicClientReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => clearField(1);
  @$pb.TagNumber(1)
  $0.BasicClientReq ensureInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isDefault => $_getBF(1);
  @$pb.TagNumber(2)
  set isDefault($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsDefault() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDefault() => clearField(2);

  @$pb.TagNumber(3)
  $0.PageReq get page => $_getN(2);
  @$pb.TagNumber(3)
  set page($0.PageReq v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);
  @$pb.TagNumber(3)
  $0.PageReq ensurePage() => $_ensure(2);
}

class EeeTokenOpen_QueryRes extends $pb.GeneratedMessage {
  factory EeeTokenOpen_QueryRes() => create();
  EeeTokenOpen_QueryRes._() : super();
  factory EeeTokenOpen_QueryRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EeeTokenOpen_QueryRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EeeTokenOpen.QueryRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pc<EeeTokenOpen_Token>(1, _omitFieldNames ? '' : 'tokens', $pb.PbFieldType.PM, subBuilder: EeeTokenOpen_Token.create)
    ..aOM<$0.PageRes>(2, _omitFieldNames ? '' : 'page', subBuilder: $0.PageRes.create)
    ..aOM<$0.Err>(3, _omitFieldNames ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_QueryRes clone() => EeeTokenOpen_QueryRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EeeTokenOpen_QueryRes copyWith(void Function(EeeTokenOpen_QueryRes) updates) => super.copyWith((message) => updates(message as EeeTokenOpen_QueryRes)) as EeeTokenOpen_QueryRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_QueryRes create() => EeeTokenOpen_QueryRes._();
  EeeTokenOpen_QueryRes createEmptyInstance() => create();
  static $pb.PbList<EeeTokenOpen_QueryRes> createRepeated() => $pb.PbList<EeeTokenOpen_QueryRes>();
  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen_QueryRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EeeTokenOpen_QueryRes>(create);
  static EeeTokenOpen_QueryRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EeeTokenOpen_Token> get tokens => $_getList(0);

  @$pb.TagNumber(2)
  $0.PageRes get page => $_getN(1);
  @$pb.TagNumber(2)
  set page($0.PageRes v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
  @$pb.TagNumber(2)
  $0.PageRes ensurePage() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Err get err => $_getN(2);
  @$pb.TagNumber(3)
  set err($0.Err v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErr() => $_has(2);
  @$pb.TagNumber(3)
  void clearErr() => clearField(3);
  @$pb.TagNumber(3)
  $0.Err ensureErr() => $_ensure(2);
}

class EeeTokenOpen extends $pb.GeneratedMessage {
  factory EeeTokenOpen() => create();
  EeeTokenOpen._() : super();
  factory EeeTokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EeeTokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EeeTokenOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EeeTokenOpen clone() => EeeTokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EeeTokenOpen copyWith(void Function(EeeTokenOpen) updates) => super.copyWith((message) => updates(message as EeeTokenOpen)) as EeeTokenOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen create() => EeeTokenOpen._();
  EeeTokenOpen createEmptyInstance() => create();
  static $pb.PbList<EeeTokenOpen> createRepeated() => $pb.PbList<EeeTokenOpen>();
  @$core.pragma('dart2js:noInline')
  static EeeTokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EeeTokenOpen>(create);
  static EeeTokenOpen? _defaultInstance;
}

class TokenOpen_Price extends $pb.GeneratedMessage {
  factory TokenOpen_Price() => create();
  TokenOpen_Price._() : super();
  factory TokenOpen_Price.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen_Price.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TokenOpen.Price', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'rank')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'supply')
    ..aOS(6, _omitFieldNames ? '' : 'maxSupply', protoName: 'maxSupply')
    ..aOS(7, _omitFieldNames ? '' : 'marketCapUsd', protoName: 'marketCapUsd')
    ..aOS(8, _omitFieldNames ? '' : 'volumeUsd24Hr', protoName: 'volumeUsd24Hr')
    ..aOS(9, _omitFieldNames ? '' : 'priceUsd', protoName: 'priceUsd')
    ..aOS(10, _omitFieldNames ? '' : 'changePercent24Hr', protoName: 'changePercent24Hr')
    ..aOS(11, _omitFieldNames ? '' : 'vwap24Hr', protoName: 'vwap24Hr')
    ..aOS(12, _omitFieldNames ? '' : 'explorer')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen_Price clone() => TokenOpen_Price()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen_Price copyWith(void Function(TokenOpen_Price) updates) => super.copyWith((message) => updates(message as TokenOpen_Price)) as TokenOpen_Price;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenOpen_Price create() => TokenOpen_Price._();
  TokenOpen_Price createEmptyInstance() => create();
  static $pb.PbList<TokenOpen_Price> createRepeated() => $pb.PbList<TokenOpen_Price>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen_Price getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen_Price>(create);
  static TokenOpen_Price? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get rank => $_getSZ(1);
  @$pb.TagNumber(2)
  set rank($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRank() => $_has(1);
  @$pb.TagNumber(2)
  void clearRank() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get symbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set symbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get supply => $_getSZ(4);
  @$pb.TagNumber(5)
  set supply($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSupply() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupply() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get maxSupply => $_getSZ(5);
  @$pb.TagNumber(6)
  set maxSupply($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxSupply() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxSupply() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get marketCapUsd => $_getSZ(6);
  @$pb.TagNumber(7)
  set marketCapUsd($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMarketCapUsd() => $_has(6);
  @$pb.TagNumber(7)
  void clearMarketCapUsd() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get volumeUsd24Hr => $_getSZ(7);
  @$pb.TagNumber(8)
  set volumeUsd24Hr($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVolumeUsd24Hr() => $_has(7);
  @$pb.TagNumber(8)
  void clearVolumeUsd24Hr() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get priceUsd => $_getSZ(8);
  @$pb.TagNumber(9)
  set priceUsd($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPriceUsd() => $_has(8);
  @$pb.TagNumber(9)
  void clearPriceUsd() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get changePercent24Hr => $_getSZ(9);
  @$pb.TagNumber(10)
  set changePercent24Hr($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasChangePercent24Hr() => $_has(9);
  @$pb.TagNumber(10)
  void clearChangePercent24Hr() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get vwap24Hr => $_getSZ(10);
  @$pb.TagNumber(11)
  set vwap24Hr($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasVwap24Hr() => $_has(10);
  @$pb.TagNumber(11)
  void clearVwap24Hr() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get explorer => $_getSZ(11);
  @$pb.TagNumber(12)
  set explorer($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasExplorer() => $_has(11);
  @$pb.TagNumber(12)
  void clearExplorer() => clearField(12);
}

class TokenOpen_Rate extends $pb.GeneratedMessage {
  factory TokenOpen_Rate() => create();
  TokenOpen_Rate._() : super();
  factory TokenOpen_Rate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen_Rate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TokenOpen.Rate', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen_Rate clone() => TokenOpen_Rate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen_Rate copyWith(void Function(TokenOpen_Rate) updates) => super.copyWith((message) => updates(message as TokenOpen_Rate)) as TokenOpen_Rate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenOpen_Rate create() => TokenOpen_Rate._();
  TokenOpen_Rate createEmptyInstance() => create();
  static $pb.PbList<TokenOpen_Rate> createRepeated() => $pb.PbList<TokenOpen_Rate>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen_Rate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen_Rate>(create);
  static TokenOpen_Rate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class TokenOpen_PriceRateRes extends $pb.GeneratedMessage {
  factory TokenOpen_PriceRateRes() => create();
  TokenOpen_PriceRateRes._() : super();
  factory TokenOpen_PriceRateRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen_PriceRateRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TokenOpen.PriceRateRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pc<TokenOpen_Price>(1, _omitFieldNames ? '' : 'prices', $pb.PbFieldType.PM, subBuilder: TokenOpen_Price.create)
    ..pc<TokenOpen_Rate>(2, _omitFieldNames ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: TokenOpen_Rate.create)
    ..aOM<$0.Err>(3, _omitFieldNames ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen_PriceRateRes clone() => TokenOpen_PriceRateRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen_PriceRateRes copyWith(void Function(TokenOpen_PriceRateRes) updates) => super.copyWith((message) => updates(message as TokenOpen_PriceRateRes)) as TokenOpen_PriceRateRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenOpen_PriceRateRes create() => TokenOpen_PriceRateRes._();
  TokenOpen_PriceRateRes createEmptyInstance() => create();
  static $pb.PbList<TokenOpen_PriceRateRes> createRepeated() => $pb.PbList<TokenOpen_PriceRateRes>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen_PriceRateRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen_PriceRateRes>(create);
  static TokenOpen_PriceRateRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TokenOpen_Price> get prices => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<TokenOpen_Rate> get rates => $_getList(1);

  @$pb.TagNumber(3)
  $0.Err get err => $_getN(2);
  @$pb.TagNumber(3)
  set err($0.Err v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErr() => $_has(2);
  @$pb.TagNumber(3)
  void clearErr() => clearField(3);
  @$pb.TagNumber(3)
  $0.Err ensureErr() => $_ensure(2);
}

class TokenOpen extends $pb.GeneratedMessage {
  factory TokenOpen() => create();
  TokenOpen._() : super();
  factory TokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TokenOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen clone() => TokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen copyWith(void Function(TokenOpen) updates) => super.copyWith((message) => updates(message as TokenOpen)) as TokenOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenOpen create() => TokenOpen._();
  TokenOpen createEmptyInstance() => create();
  static $pb.PbList<TokenOpen> createRepeated() => $pb.PbList<TokenOpen>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen>(create);
  static TokenOpen? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
