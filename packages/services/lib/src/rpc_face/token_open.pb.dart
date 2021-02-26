///
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class TokenSharedOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenSharedOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Symbol', protoName: 'Symbol')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Publisher', protoName: 'Publisher')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Project', protoName: 'Project')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LogoUrl', protoName: 'LogoUrl')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LogoBytes', protoName: 'LogoBytes')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChainType', protoName: 'ChainType')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mark', protoName: 'Mark')
    ..hasRequiredFields = false
  ;

  TokenSharedOpen._() : super();
  factory TokenSharedOpen({
    $core.String symbol,
    $core.String name,
    $core.String publisher,
    $core.String project,
    $core.String logoUrl,
    $core.String logoBytes,
    $core.String chainType,
    $core.String mark,
  }) {
    final _result = create();
    if (symbol != null) {
      _result.symbol = symbol;
    }
    if (name != null) {
      _result.name = name;
    }
    if (publisher != null) {
      _result.publisher = publisher;
    }
    if (project != null) {
      _result.project = project;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (logoBytes != null) {
      _result.logoBytes = logoBytes;
    }
    if (chainType != null) {
      _result.chainType = chainType;
    }
    if (mark != null) {
      _result.mark = mark;
    }
    return _result;
  }
  factory TokenSharedOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenSharedOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenSharedOpen clone() => TokenSharedOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenSharedOpen copyWith(void Function(TokenSharedOpen) updates) => super.copyWith((message) => updates(message as TokenSharedOpen)) as TokenSharedOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenSharedOpen create() => TokenSharedOpen._();
  TokenSharedOpen createEmptyInstance() => create();
  static $pb.PbList<TokenSharedOpen> createRepeated() => $pb.PbList<TokenSharedOpen>();
  @$core.pragma('dart2js:noInline')
  static TokenSharedOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenSharedOpen>(create);
  static TokenSharedOpen _defaultInstance;

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
}

class EthereumTokenOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EthereumTokenOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..aOM<TokenSharedOpen>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TokenShared', protoName: 'TokenShared', subBuilder: TokenSharedOpen.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Decimal', $pb.PbFieldType.O3, protoName: 'Decimal')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'GasLimit', protoName: 'GasLimit')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Contract', protoName: 'Contract')
    ..hasRequiredFields = false
  ;

  EthereumTokenOpen._() : super();
  factory EthereumTokenOpen({
    $core.String id,
    TokenSharedOpen tokenShared,
    $core.int decimal,
    $fixnum.Int64 gasLimit,
    $core.String contract,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (tokenShared != null) {
      _result.tokenShared = tokenShared;
    }
    if (decimal != null) {
      _result.decimal = decimal;
    }
    if (gasLimit != null) {
      _result.gasLimit = gasLimit;
    }
    if (contract != null) {
      _result.contract = contract;
    }
    return _result;
  }
  factory EthereumTokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthereumTokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthereumTokenOpen clone() => EthereumTokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthereumTokenOpen copyWith(void Function(EthereumTokenOpen) updates) => super.copyWith((message) => updates(message as EthereumTokenOpen)) as EthereumTokenOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EthereumTokenOpen create() => EthereumTokenOpen._();
  EthereumTokenOpen createEmptyInstance() => create();
  static $pb.PbList<EthereumTokenOpen> createRepeated() => $pb.PbList<EthereumTokenOpen>();
  @$core.pragma('dart2js:noInline')
  static EthereumTokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthereumTokenOpen>(create);
  static EthereumTokenOpen _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  TokenSharedOpen get tokenShared => $_getN(1);
  @$pb.TagNumber(2)
  set tokenShared(TokenSharedOpen v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTokenShared() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokenShared() => clearField(2);
  @$pb.TagNumber(2)
  TokenSharedOpen ensureTokenShared() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get decimal => $_getIZ(2);
  @$pb.TagNumber(3)
  set decimal($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDecimal() => $_has(2);
  @$pb.TagNumber(3)
  void clearDecimal() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get gasLimit => $_getI64(3);
  @$pb.TagNumber(4)
  set gasLimit($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearGasLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get contract => $_getSZ(4);
  @$pb.TagNumber(5)
  set contract($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContract() => $_has(4);
  @$pb.TagNumber(5)
  void clearContract() => clearField(5);
}

class EthTokenOpen_Token extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EthTokenOpen.Token', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EthereumTokenId', protoName: 'EthereumTokenId')
    ..aOM<EthereumTokenOpen>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EthereumToken', protoName: 'EthereumToken', subBuilder: EthereumTokenOpen.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Position', $pb.PbFieldType.OD, protoName: 'Position')
    ..hasRequiredFields = false
  ;

  EthTokenOpen_Token._() : super();
  factory EthTokenOpen_Token({
    $core.String id,
    $core.String ethereumTokenId,
    EthereumTokenOpen ethereumToken,
    $core.double position,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (ethereumTokenId != null) {
      _result.ethereumTokenId = ethereumTokenId;
    }
    if (ethereumToken != null) {
      _result.ethereumToken = ethereumToken;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory EthTokenOpen_Token.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_Token.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_Token clone() => EthTokenOpen_Token()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_Token copyWith(void Function(EthTokenOpen_Token) updates) => super.copyWith((message) => updates(message as EthTokenOpen_Token)) as EthTokenOpen_Token; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_Token create() => EthTokenOpen_Token._();
  EthTokenOpen_Token createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_Token> createRepeated() => $pb.PbList<EthTokenOpen_Token>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_Token getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_Token>(create);
  static EthTokenOpen_Token _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ethereumTokenId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ethereumTokenId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEthereumTokenId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEthereumTokenId() => clearField(2);

  @$pb.TagNumber(3)
  EthereumTokenOpen get ethereumToken => $_getN(2);
  @$pb.TagNumber(3)
  set ethereumToken(EthereumTokenOpen v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEthereumToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearEthereumToken() => clearField(3);
  @$pb.TagNumber(3)
  EthereumTokenOpen ensureEthereumToken() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get position => $_getN(3);
  @$pb.TagNumber(4)
  set position($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => clearField(4);
}

class EthTokenOpen_QueryReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EthTokenOpen.QueryReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.BasicClientReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'info', subBuilder: $0.BasicClientReq.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDefault', protoName: 'isDefault')
    ..aOM<$0.PageReq>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', subBuilder: $0.PageReq.create)
    ..hasRequiredFields = false
  ;

  EthTokenOpen_QueryReq._() : super();
  factory EthTokenOpen_QueryReq({
    $0.BasicClientReq info,
    $core.bool isDefault,
    $0.PageReq page,
  }) {
    final _result = create();
    if (info != null) {
      _result.info = info;
    }
    if (isDefault != null) {
      _result.isDefault = isDefault;
    }
    if (page != null) {
      _result.page = page;
    }
    return _result;
  }
  factory EthTokenOpen_QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryReq clone() => EthTokenOpen_QueryReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryReq copyWith(void Function(EthTokenOpen_QueryReq) updates) => super.copyWith((message) => updates(message as EthTokenOpen_QueryReq)) as EthTokenOpen_QueryReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryReq create() => EthTokenOpen_QueryReq._();
  EthTokenOpen_QueryReq createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_QueryReq> createRepeated() => $pb.PbList<EthTokenOpen_QueryReq>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_QueryReq>(create);
  static EthTokenOpen_QueryReq _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EthTokenOpen.QueryRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..pc<EthTokenOpen_Token>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokens', $pb.PbFieldType.PM, subBuilder: EthTokenOpen_Token.create)
    ..aOM<$0.PageRes>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', subBuilder: $0.PageRes.create)
    ..aOM<$0.Err>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  EthTokenOpen_QueryRes._() : super();
  factory EthTokenOpen_QueryRes({
    $core.Iterable<EthTokenOpen_Token> tokens,
    $0.PageRes page,
    $0.Err err,
  }) {
    final _result = create();
    if (tokens != null) {
      _result.tokens.addAll(tokens);
    }
    if (page != null) {
      _result.page = page;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory EthTokenOpen_QueryRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen_QueryRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryRes clone() => EthTokenOpen_QueryRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen_QueryRes copyWith(void Function(EthTokenOpen_QueryRes) updates) => super.copyWith((message) => updates(message as EthTokenOpen_QueryRes)) as EthTokenOpen_QueryRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryRes create() => EthTokenOpen_QueryRes._();
  EthTokenOpen_QueryRes createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen_QueryRes> createRepeated() => $pb.PbList<EthTokenOpen_QueryRes>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen_QueryRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen_QueryRes>(create);
  static EthTokenOpen_QueryRes _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EthTokenOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  EthTokenOpen._() : super();
  factory EthTokenOpen() => create();
  factory EthTokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EthTokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EthTokenOpen clone() => EthTokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EthTokenOpen copyWith(void Function(EthTokenOpen) updates) => super.copyWith((message) => updates(message as EthTokenOpen)) as EthTokenOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen create() => EthTokenOpen._();
  EthTokenOpen createEmptyInstance() => create();
  static $pb.PbList<EthTokenOpen> createRepeated() => $pb.PbList<EthTokenOpen>();
  @$core.pragma('dart2js:noInline')
  static EthTokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EthTokenOpen>(create);
  static EthTokenOpen _defaultInstance;
}

class TokenOpen_PriceRateRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenOpen.PriceRateRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..aOM<$0.Err>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $0.Err.create)
    ..hasRequiredFields = false
  ;

  TokenOpen_PriceRateRes._() : super();
  factory TokenOpen_PriceRateRes({
    $core.List<$core.int> data,
    $0.Err err,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (err != null) {
      _result.err = err;
    }
    return _result;
  }
  factory TokenOpen_PriceRateRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen_PriceRateRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen_PriceRateRes clone() => TokenOpen_PriceRateRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen_PriceRateRes copyWith(void Function(TokenOpen_PriceRateRes) updates) => super.copyWith((message) => updates(message as TokenOpen_PriceRateRes)) as TokenOpen_PriceRateRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenOpen_PriceRateRes create() => TokenOpen_PriceRateRes._();
  TokenOpen_PriceRateRes createEmptyInstance() => create();
  static $pb.PbList<TokenOpen_PriceRateRes> createRepeated() => $pb.PbList<TokenOpen_PriceRateRes>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen_PriceRateRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen_PriceRateRes>(create);
  static TokenOpen_PriceRateRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);

  @$pb.TagNumber(3)
  $0.Err get err => $_getN(1);
  @$pb.TagNumber(3)
  set err($0.Err v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(3)
  void clearErr() => clearField(3);
  @$pb.TagNumber(3)
  $0.Err ensureErr() => $_ensure(1);
}

class TokenOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TokenOpen._() : super();
  factory TokenOpen() => create();
  factory TokenOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenOpen clone() => TokenOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenOpen copyWith(void Function(TokenOpen) updates) => super.copyWith((message) => updates(message as TokenOpen)) as TokenOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenOpen create() => TokenOpen._();
  TokenOpen createEmptyInstance() => create();
  static $pb.PbList<TokenOpen> createRepeated() => $pb.PbList<TokenOpen>();
  @$core.pragma('dart2js:noInline')
  static TokenOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenOpen>(create);
  static TokenOpen _defaultInstance;
}

