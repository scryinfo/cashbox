///
//  Generated code. Do not modify.
//  source: cashbox_config_open.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxConfigOpen_LatestConfigRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CashboxConfigOpen.LatestConfigRes', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, 'err', subBuilder: $0.Err.create)
    ..aOS(2, 'cashboxVersion', protoName: 'cashboxVersion')
    ..aOS(3, 'configVersion', protoName: 'configVersion')
    ..aOS(4, 'conf')
    ..hasRequiredFields = false
  ;

  CashboxConfigOpen_LatestConfigRes._() : super();
  factory CashboxConfigOpen_LatestConfigRes() => create();
  factory CashboxConfigOpen_LatestConfigRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen_LatestConfigRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CashboxConfigOpen_LatestConfigRes clone() => CashboxConfigOpen_LatestConfigRes()..mergeFromMessage(this);
  CashboxConfigOpen_LatestConfigRes copyWith(void Function(CashboxConfigOpen_LatestConfigRes) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen_LatestConfigRes));
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CashboxConfigOpen', package: const $pb.PackageName('rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CashboxConfigOpen._() : super();
  factory CashboxConfigOpen() => create();
  factory CashboxConfigOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CashboxConfigOpen clone() => CashboxConfigOpen()..mergeFromMessage(this);
  CashboxConfigOpen copyWith(void Function(CashboxConfigOpen) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen create() => CashboxConfigOpen._();
  CashboxConfigOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxConfigOpen> createRepeated() => $pb.PbList<CashboxConfigOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxConfigOpen>(create);
  static CashboxConfigOpen _defaultInstance;
}

