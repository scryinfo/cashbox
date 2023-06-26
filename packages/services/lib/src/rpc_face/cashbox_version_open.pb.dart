//
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxVersionOpen_UpgradeRes extends $pb.GeneratedMessage {
  factory CashboxVersionOpen_UpgradeRes() => create();
  CashboxVersionOpen_UpgradeRes._() : super();
  factory CashboxVersionOpen_UpgradeRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen_UpgradeRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CashboxVersionOpen.UpgradeRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, _omitFieldNames ? '' : 'err', subBuilder: $0.Err.create)
    ..aOS(2, _omitFieldNames ? '' : 'upgradeStatus', protoName: 'upgradeStatus')
    ..aOS(3, _omitFieldNames ? '' : 'upgradeVersion', protoName: 'upgradeVersion')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen_UpgradeRes clone() => CashboxVersionOpen_UpgradeRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen_UpgradeRes copyWith(void Function(CashboxVersionOpen_UpgradeRes) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen_UpgradeRes)) as CashboxVersionOpen_UpgradeRes;

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
  factory CashboxVersionOpen() => create();
  CashboxVersionOpen._() : super();
  factory CashboxVersionOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CashboxVersionOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen clone() => CashboxVersionOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersionOpen copyWith(void Function(CashboxVersionOpen) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen)) as CashboxVersionOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen create() => CashboxVersionOpen._();
  CashboxVersionOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxVersionOpen> createRepeated() => $pb.PbList<CashboxVersionOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersionOpen>(create);
  static CashboxVersionOpen? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
