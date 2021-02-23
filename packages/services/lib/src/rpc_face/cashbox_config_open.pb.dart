///
//  Generated code. Do not modify.
//  source: cashbox_config_open.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxConfigOpen_LatestConfigRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxConfigOpen.LatestConfigRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $0.Err.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxVersion', protoName: 'cashboxVersion')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'configVersion', protoName: 'configVersion')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conf')
    ..hasRequiredFields = false
  ;

  CashboxConfigOpen_LatestConfigRes._() : super();
  factory CashboxConfigOpen_LatestConfigRes({
    $0.Err err,
    $core.String cashboxVersion,
    $core.String configVersion,
    $core.String conf,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (cashboxVersion != null) {
      _result.cashboxVersion = cashboxVersion;
    }
    if (configVersion != null) {
      _result.configVersion = configVersion;
    }
    if (conf != null) {
      _result.conf = conf;
    }
    return _result;
  }
  factory CashboxConfigOpen_LatestConfigRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen_LatestConfigRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen_LatestConfigRes clone() => CashboxConfigOpen_LatestConfigRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen_LatestConfigRes copyWith(void Function(CashboxConfigOpen_LatestConfigRes) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen_LatestConfigRes)) as CashboxConfigOpen_LatestConfigRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen_LatestConfigRes create() => CashboxConfigOpen_LatestConfigRes._();
  CashboxConfigOpen_LatestConfigRes createEmptyInstance() => create();
  static $pb.PbList<CashboxConfigOpen_LatestConfigRes> createRepeated() => $pb.PbList<CashboxConfigOpen_LatestConfigRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen_LatestConfigRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxConfigOpen_LatestConfigRes>(create);
  static CashboxConfigOpen_LatestConfigRes _defaultInstance;

  @$pb.TagNumber(1)
  $0.Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err($0.Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  $0.Err ensureErr() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get cashboxVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set cashboxVersion($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCashboxVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearCashboxVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get configVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set configVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfigVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfigVersion() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get conf => $_getSZ(3);
  @$pb.TagNumber(4)
  set conf($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConf() => $_has(3);
  @$pb.TagNumber(4)
  void clearConf() => clearField(4);
}

class CashboxConfigOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxConfigOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CashboxConfigOpen._() : super();
  factory CashboxConfigOpen() => create();
  factory CashboxConfigOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen clone() => CashboxConfigOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen copyWith(void Function(CashboxConfigOpen) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen)) as CashboxConfigOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen create() => CashboxConfigOpen._();
  CashboxConfigOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxConfigOpen> createRepeated() => $pb.PbList<CashboxConfigOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxConfigOpen>(create);
  static CashboxConfigOpen _defaultInstance;
}

