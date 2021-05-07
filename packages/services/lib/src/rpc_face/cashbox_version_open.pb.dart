///
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxVersionOpen_UpgradeRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CashboxVersionOpen.UpgradeRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, 'err', subBuilder: $0.Err.create)
    ..aOS(2, 'upgradeStatus', protoName: 'upgradeStatus')
    ..aOS(3, 'upgradeVersion', protoName: 'upgradeVersion')
    ..hasRequiredFields = false
  ;

  CashboxVersionOpen_UpgradeRes._() : super();
  factory CashboxVersionOpen_UpgradeRes() => create();
  factory CashboxVersionOpen_UpgradeRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen_UpgradeRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CashboxVersionOpen_UpgradeRes clone() => CashboxVersionOpen_UpgradeRes()..mergeFromMessage(this);
  CashboxVersionOpen_UpgradeRes copyWith(void Function(CashboxVersionOpen_UpgradeRes) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen_UpgradeRes));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen_UpgradeRes create() => CashboxVersionOpen_UpgradeRes._();
  CashboxVersionOpen_UpgradeRes createEmptyInstance() => create();
  static $pb.PbList<CashboxVersionOpen_UpgradeRes> createRepeated() => $pb.PbList<CashboxVersionOpen_UpgradeRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen_UpgradeRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersionOpen_UpgradeRes>(create);
  static CashboxVersionOpen_UpgradeRes _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CashboxVersionOpen', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CashboxVersionOpen._() : super();
  factory CashboxVersionOpen() => create();
  factory CashboxVersionOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersionOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CashboxVersionOpen clone() => CashboxVersionOpen()..mergeFromMessage(this);
  CashboxVersionOpen copyWith(void Function(CashboxVersionOpen) updates) => super.copyWith((message) => updates(message as CashboxVersionOpen));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen create() => CashboxVersionOpen._();
  CashboxVersionOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxVersionOpen> createRepeated() => $pb.PbList<CashboxVersionOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersionOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersionOpen>(create);
  static CashboxVersionOpen _defaultInstance;
}

