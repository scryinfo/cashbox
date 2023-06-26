//
//  Generated code. Do not modify.
//  source: cashbox_config_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $0;

class CashboxConfigOpen_LatestConfigRes extends $pb.GeneratedMessage {
  factory CashboxConfigOpen_LatestConfigRes() => create();
  CashboxConfigOpen_LatestConfigRes._() : super();
  factory CashboxConfigOpen_LatestConfigRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen_LatestConfigRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CashboxConfigOpen.LatestConfigRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$0.Err>(1, _omitFieldNames ? '' : 'err', subBuilder: $0.Err.create)
    ..aOS(2, _omitFieldNames ? '' : 'cashboxVersion', protoName: 'cashboxVersion')
    ..aOS(3, _omitFieldNames ? '' : 'configVersion', protoName: 'configVersion')
    ..aOS(4, _omitFieldNames ? '' : 'conf')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen_LatestConfigRes clone() => CashboxConfigOpen_LatestConfigRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen_LatestConfigRes copyWith(void Function(CashboxConfigOpen_LatestConfigRes) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen_LatestConfigRes)) as CashboxConfigOpen_LatestConfigRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen_LatestConfigRes create() => CashboxConfigOpen_LatestConfigRes._();
  CashboxConfigOpen_LatestConfigRes createEmptyInstance() => create();
  static $pb.PbList<CashboxConfigOpen_LatestConfigRes> createRepeated() => $pb.PbList<CashboxConfigOpen_LatestConfigRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen_LatestConfigRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxConfigOpen_LatestConfigRes>(create);
  static CashboxConfigOpen_LatestConfigRes? _defaultInstance;

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
  factory CashboxConfigOpen() => create();
  CashboxConfigOpen._() : super();
  factory CashboxConfigOpen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxConfigOpen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CashboxConfigOpen', package: const $pb.PackageName(_omitMessageNames ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen clone() => CashboxConfigOpen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxConfigOpen copyWith(void Function(CashboxConfigOpen) updates) => super.copyWith((message) => updates(message as CashboxConfigOpen)) as CashboxConfigOpen;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen create() => CashboxConfigOpen._();
  CashboxConfigOpen createEmptyInstance() => create();
  static $pb.PbList<CashboxConfigOpen> createRepeated() => $pb.PbList<CashboxConfigOpen>();
  @$core.pragma('dart2js:noInline')
  static CashboxConfigOpen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxConfigOpen>(create);
  static CashboxConfigOpen? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
