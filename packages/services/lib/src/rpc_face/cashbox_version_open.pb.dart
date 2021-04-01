///
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxVersionOpen_UpgradeRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersionOpen.UpgradeRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $0.Err.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgradeStatus', protoName: 'upgradeStatus')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgradeVersion', protoName: 'upgradeVersion')
    ..hasRequiredFields = false
  ;

  CashboxVersionOpen_UpgradeRes._() : super();
  factory CashboxVersionOpen_UpgradeRes({
    $0.Err? err,
    $core.String? upgradeStatus,
    $core.String? upgradeVersion,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (upgradeStatus != null) {
      _result.upgradeStatus = upgradeStatus;
    }
    if (upgradeVersion != null) {
      _result.upgradeVersion = upgradeVersion;
    }
    return _result;
  }
  factory CashboxVersionOpen_UpgradeRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen_UpgradeRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen_UpgradeRes clone() => CashboxVersionOpen_UpgradeRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen_UpgradeRes copyWith(void Function(CashboxVersionOpen_UpgradeRes) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen_UpgradeRes)) as CashboxVersionOpen_UpgradeRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen_UpgradeRes create() => CashboxVersionOpen_UpgradeRes._();
  CashboxVersionOpen_UpgradeRes createEmptyInstance() => create();
  static $pb.PbList<CashboxVersionOpen_UpgradeRes> createRepeated() => $pb.PbList<CashboxVersionOpen_UpgradeRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen_UpgradeRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersionOpen_UpgradeRes>(create);
  static CashboxVersionOpen_UpgradeRes? _defaultInstance;

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
  $core.String get upgradeStatus => $_getSZ(1);
  @$pb.TagNumber(2)
  set upgradeStatus($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpgradeStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpgradeStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get upgradeVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set upgradeVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpgradeVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpgradeVersion() => clearField(3);
}

class CashboxVersionOpen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersionOpen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CashboxVersionOpen._() : super();
  factory CashboxVersionOpen() => create();
  factory CashboxVersionOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen clone() => CashboxVersionOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen copyWith(void Function(CashboxVersionOpen) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen)) as CashboxVersionOpen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen create() => CashboxVersionOpen._();
  CashboxVersionOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxVersionOpen> createRepeated() => $pb.PbList<CashboxVersionOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersionOpen>(create);
  static CashboxVersionOpen? _defaultInstance;
}

