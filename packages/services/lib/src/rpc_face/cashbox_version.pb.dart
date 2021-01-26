///
//  Generated code. Do not modify.
//  source: cashbox_version.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'base.pb.dart' as $1;

class FileMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileMeta', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.Languages>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VersionDescription', protoName: 'VersionDescription', subBuilder: $1.Languages.create)
    ..aOM<$1.Languages>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'NewFunctions', protoName: 'NewFunctions', subBuilder: $1.Languages.create)
    ..aOM<$1.Languages>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FixedBugs', protoName: 'FixedBugs', subBuilder: $1.Languages.create)
    ..aOM<$1.Languages>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Author', protoName: 'Author', subBuilder: $1.Languages.create)
    ..aOM<$1.Languages>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Compatibility', protoName: 'Compatibility', subBuilder: $1.Languages.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileName', protoName: 'FileName')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileSizeOfMB', protoName: 'FileSizeOfMB')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileHash256', protoName: 'FileHash256')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DownloadLinkCloud', protoName: 'DownloadLinkCloud')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Signature', protoName: 'Signature')
    ..hasRequiredFields = false
  ;

  FileMeta._() : super();
  factory FileMeta({
    $1.Languages versionDescription,
    $1.Languages newFunctions,
    $1.Languages fixedBugs,
    $1.Languages author,
    $1.Languages compatibility,
    $core.String fileName,
    $fixnum.Int64 fileSizeOfMB,
    $core.String fileHash256,
    $core.String downloadLinkCloud,
    $core.String signature,
  }) {
    final _result = create();
    if (versionDescription != null) {
      _result.versionDescription = versionDescription;
    }
    if (newFunctions != null) {
      _result.newFunctions = newFunctions;
    }
    if (fixedBugs != null) {
      _result.fixedBugs = fixedBugs;
    }
    if (author != null) {
      _result.author = author;
    }
    if (compatibility != null) {
      _result.compatibility = compatibility;
    }
    if (fileName != null) {
      _result.fileName = fileName;
    }
    if (fileSizeOfMB != null) {
      _result.fileSizeOfMB = fileSizeOfMB;
    }
    if (fileHash256 != null) {
      _result.fileHash256 = fileHash256;
    }
    if (downloadLinkCloud != null) {
      _result.downloadLinkCloud = downloadLinkCloud;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory FileMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileMeta clone() => FileMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileMeta copyWith(void Function(FileMeta) updates) => super.copyWith((message) => updates(message as FileMeta)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileMeta create() => FileMeta._();
  FileMeta createEmptyInstance() => create();
  static $pb.PbList<FileMeta> createRepeated() => $pb.PbList<FileMeta>();
  @$core.pragma('dart2js:noInline')
  static FileMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileMeta>(create);
  static FileMeta _defaultInstance;

  @$pb.TagNumber(1)
  $1.Languages get versionDescription => $_getN(0);
  @$pb.TagNumber(1)
  set versionDescription($1.Languages v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersionDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionDescription() => clearField(1);
  @$pb.TagNumber(1)
  $1.Languages ensureVersionDescription() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Languages get newFunctions => $_getN(1);
  @$pb.TagNumber(2)
  set newFunctions($1.Languages v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewFunctions() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewFunctions() => clearField(2);
  @$pb.TagNumber(2)
  $1.Languages ensureNewFunctions() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Languages get fixedBugs => $_getN(2);
  @$pb.TagNumber(3)
  set fixedBugs($1.Languages v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFixedBugs() => $_has(2);
  @$pb.TagNumber(3)
  void clearFixedBugs() => clearField(3);
  @$pb.TagNumber(3)
  $1.Languages ensureFixedBugs() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Languages get author => $_getN(3);
  @$pb.TagNumber(4)
  set author($1.Languages v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthor() => clearField(4);
  @$pb.TagNumber(4)
  $1.Languages ensureAuthor() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Languages get compatibility => $_getN(4);
  @$pb.TagNumber(5)
  set compatibility($1.Languages v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCompatibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearCompatibility() => clearField(5);
  @$pb.TagNumber(5)
  $1.Languages ensureCompatibility() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get fileName => $_getSZ(5);
  @$pb.TagNumber(6)
  set fileName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFileName() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileName() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fileSizeOfMB => $_getI64(6);
  @$pb.TagNumber(7)
  set fileSizeOfMB($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFileSizeOfMB() => $_has(6);
  @$pb.TagNumber(7)
  void clearFileSizeOfMB() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get fileHash256 => $_getSZ(7);
  @$pb.TagNumber(8)
  set fileHash256($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFileHash256() => $_has(7);
  @$pb.TagNumber(8)
  void clearFileHash256() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get downloadLinkCloud => $_getSZ(8);
  @$pb.TagNumber(9)
  set downloadLinkCloud($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDownloadLinkCloud() => $_has(8);
  @$pb.TagNumber(9)
  void clearDownloadLinkCloud() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get signature => $_getSZ(9);
  @$pb.TagNumber(10)
  set signature($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSignature() => $_has(9);
  @$pb.TagNumber(10)
  void clearSignature() => clearField(10);
}

class CashboxVersion_Model extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.Model', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ReleaseTime', protoName: 'ReleaseTime')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ApkType', protoName: 'ApkType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UpgradeType', protoName: 'UpgradeType')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VersionNumber', protoName: 'VersionNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Version', protoName: 'Version')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OldVersions', protoName: 'OldVersions')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AppPlatformType', protoName: 'AppPlatformType')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RecordStatus', protoName: 'RecordStatus')
    ..aOM<FileMeta>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileMeta', protoName: 'FileMeta', subBuilder: FileMeta.create)
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CreateTime', protoName: 'CreateTime')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UpdateTime', protoName: 'UpdateTime')
    ..aInt64(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OptimisticLockVersion', protoName: 'OptimisticLockVersion')
    ..hasRequiredFields = false
  ;

  CashboxVersion_Model._() : super();
  factory CashboxVersion_Model({
    $core.String id,
    $fixnum.Int64 releaseTime,
    $core.String apkType,
    $core.String upgradeType,
    $fixnum.Int64 versionNumber,
    $core.String version,
    $core.Iterable<$core.String> oldVersions,
    $core.String appPlatformType,
    $core.String recordStatus,
    FileMeta fileMeta,
    $fixnum.Int64 createTime,
    $fixnum.Int64 updateTime,
    $fixnum.Int64 optimisticLockVersion,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (releaseTime != null) {
      _result.releaseTime = releaseTime;
    }
    if (apkType != null) {
      _result.apkType = apkType;
    }
    if (upgradeType != null) {
      _result.upgradeType = upgradeType;
    }
    if (versionNumber != null) {
      _result.versionNumber = versionNumber;
    }
    if (version != null) {
      _result.version = version;
    }
    if (oldVersions != null) {
      _result.oldVersions.addAll(oldVersions);
    }
    if (appPlatformType != null) {
      _result.appPlatformType = appPlatformType;
    }
    if (recordStatus != null) {
      _result.recordStatus = recordStatus;
    }
    if (fileMeta != null) {
      _result.fileMeta = fileMeta;
    }
    if (createTime != null) {
      _result.createTime = createTime;
    }
    if (updateTime != null) {
      _result.updateTime = updateTime;
    }
    if (optimisticLockVersion != null) {
      _result.optimisticLockVersion = optimisticLockVersion;
    }
    return _result;
  }
  factory CashboxVersion_Model.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_Model.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_Model clone() => CashboxVersion_Model()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_Model copyWith(void Function(CashboxVersion_Model) updates) => super.copyWith((message) => updates(message as CashboxVersion_Model)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_Model create() => CashboxVersion_Model._();
  CashboxVersion_Model createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_Model> createRepeated() => $pb.PbList<CashboxVersion_Model>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_Model getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_Model>(create);
  static CashboxVersion_Model _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get releaseTime => $_getI64(1);
  @$pb.TagNumber(2)
  set releaseTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReleaseTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearReleaseTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get apkType => $_getSZ(2);
  @$pb.TagNumber(3)
  set apkType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasApkType() => $_has(2);
  @$pb.TagNumber(3)
  void clearApkType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get upgradeType => $_getSZ(3);
  @$pb.TagNumber(4)
  set upgradeType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpgradeType() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpgradeType() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get versionNumber => $_getI64(4);
  @$pb.TagNumber(5)
  set versionNumber($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVersionNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersionNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get version => $_getSZ(5);
  @$pb.TagNumber(6)
  set version($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get oldVersions => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get appPlatformType => $_getSZ(7);
  @$pb.TagNumber(8)
  set appPlatformType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAppPlatformType() => $_has(7);
  @$pb.TagNumber(8)
  void clearAppPlatformType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get recordStatus => $_getSZ(8);
  @$pb.TagNumber(9)
  set recordStatus($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRecordStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecordStatus() => clearField(9);

  @$pb.TagNumber(10)
  FileMeta get fileMeta => $_getN(9);
  @$pb.TagNumber(10)
  set fileMeta(FileMeta v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasFileMeta() => $_has(9);
  @$pb.TagNumber(10)
  void clearFileMeta() => clearField(10);
  @$pb.TagNumber(10)
  FileMeta ensureFileMeta() => $_ensure(9);

  @$pb.TagNumber(11)
  $fixnum.Int64 get createTime => $_getI64(10);
  @$pb.TagNumber(11)
  set createTime($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreateTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreateTime() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get updateTime => $_getI64(11);
  @$pb.TagNumber(12)
  set updateTime($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdateTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdateTime() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get optimisticLockVersion => $_getI64(12);
  @$pb.TagNumber(13)
  set optimisticLockVersion($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasOptimisticLockVersion() => $_has(12);
  @$pb.TagNumber(13)
  void clearOptimisticLockVersion() => clearField(13);
}

class CashboxVersion_SaveReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.SaveReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<CashboxVersion_Model>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxVersion', protoName: 'cashboxVersion', subBuilder: CashboxVersion_Model.create)
    ..hasRequiredFields = false
  ;

  CashboxVersion_SaveReq._() : super();
  factory CashboxVersion_SaveReq({
    CashboxVersion_Model cashboxVersion,
  }) {
    final _result = create();
    if (cashboxVersion != null) {
      _result.cashboxVersion = cashboxVersion;
    }
    return _result;
  }
  factory CashboxVersion_SaveReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_SaveReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_SaveReq clone() => CashboxVersion_SaveReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_SaveReq copyWith(void Function(CashboxVersion_SaveReq) updates) => super.copyWith((message) => updates(message as CashboxVersion_SaveReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_SaveReq create() => CashboxVersion_SaveReq._();
  CashboxVersion_SaveReq createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_SaveReq> createRepeated() => $pb.PbList<CashboxVersion_SaveReq>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_SaveReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_SaveReq>(create);
  static CashboxVersion_SaveReq _defaultInstance;

  @$pb.TagNumber(1)
  CashboxVersion_Model get cashboxVersion => $_getN(0);
  @$pb.TagNumber(1)
  set cashboxVersion(CashboxVersion_Model v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCashboxVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearCashboxVersion() => clearField(1);
  @$pb.TagNumber(1)
  CashboxVersion_Model ensureCashboxVersion() => $_ensure(0);
}

class CashboxVersion_SaveRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.SaveRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..aOM<CashboxVersion_Model>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashboxVersion', protoName: 'cashboxVersion', subBuilder: CashboxVersion_Model.create)
    ..hasRequiredFields = false
  ;

  CashboxVersion_SaveRes._() : super();
  factory CashboxVersion_SaveRes({
    $1.Err err,
    CashboxVersion_Model cashboxVersion,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (cashboxVersion != null) {
      _result.cashboxVersion = cashboxVersion;
    }
    return _result;
  }
  factory CashboxVersion_SaveRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_SaveRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_SaveRes clone() => CashboxVersion_SaveRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_SaveRes copyWith(void Function(CashboxVersion_SaveRes) updates) => super.copyWith((message) => updates(message as CashboxVersion_SaveRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_SaveRes create() => CashboxVersion_SaveRes._();
  CashboxVersion_SaveRes createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_SaveRes> createRepeated() => $pb.PbList<CashboxVersion_SaveRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_SaveRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_SaveRes>(create);
  static CashboxVersion_SaveRes _defaultInstance;

  @$pb.TagNumber(1)
  $1.Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err($1.Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  $1.Err ensureErr() => $_ensure(0);

  @$pb.TagNumber(2)
  CashboxVersion_Model get cashboxVersion => $_getN(1);
  @$pb.TagNumber(2)
  set cashboxVersion(CashboxVersion_Model v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCashboxVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearCashboxVersion() => clearField(2);
  @$pb.TagNumber(2)
  CashboxVersion_Model ensureCashboxVersion() => $_ensure(1);
}

class CashboxVersion_GetByIdRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.GetByIdRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..aOM<CashboxVersion_Model>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apk', subBuilder: CashboxVersion_Model.create)
    ..hasRequiredFields = false
  ;

  CashboxVersion_GetByIdRes._() : super();
  factory CashboxVersion_GetByIdRes({
    $1.Err err,
    CashboxVersion_Model apk,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (apk != null) {
      _result.apk = apk;
    }
    return _result;
  }
  factory CashboxVersion_GetByIdRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_GetByIdRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_GetByIdRes clone() => CashboxVersion_GetByIdRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_GetByIdRes copyWith(void Function(CashboxVersion_GetByIdRes) updates) => super.copyWith((message) => updates(message as CashboxVersion_GetByIdRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_GetByIdRes create() => CashboxVersion_GetByIdRes._();
  CashboxVersion_GetByIdRes createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_GetByIdRes> createRepeated() => $pb.PbList<CashboxVersion_GetByIdRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_GetByIdRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_GetByIdRes>(create);
  static CashboxVersion_GetByIdRes _defaultInstance;

  @$pb.TagNumber(1)
  $1.Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err($1.Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  $1.Err ensureErr() => $_ensure(0);

  @$pb.TagNumber(2)
  CashboxVersion_Model get apk => $_getN(1);
  @$pb.TagNumber(2)
  set apk(CashboxVersion_Model v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasApk() => $_has(1);
  @$pb.TagNumber(2)
  void clearApk() => clearField(2);
  @$pb.TagNumber(2)
  CashboxVersion_Model ensureApk() => $_ensure(1);
}

class CashboxVersion_QueryReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.QueryReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.PageReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', subBuilder: $1.PageReq.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  CashboxVersion_QueryReq._() : super();
  factory CashboxVersion_QueryReq({
    $1.PageReq page,
    $core.String type,
    $core.String query,
    $core.String status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (type != null) {
      _result.type = type;
    }
    if (query != null) {
      _result.query = query;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory CashboxVersion_QueryReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_QueryReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_QueryReq clone() => CashboxVersion_QueryReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_QueryReq copyWith(void Function(CashboxVersion_QueryReq) updates) => super.copyWith((message) => updates(message as CashboxVersion_QueryReq)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_QueryReq create() => CashboxVersion_QueryReq._();
  CashboxVersion_QueryReq createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_QueryReq> createRepeated() => $pb.PbList<CashboxVersion_QueryReq>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_QueryReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_QueryReq>(create);
  static CashboxVersion_QueryReq _defaultInstance;

  @$pb.TagNumber(1)
  $1.PageReq get page => $_getN(0);
  @$pb.TagNumber(1)
  set page($1.PageReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);
  @$pb.TagNumber(1)
  $1.PageReq ensurePage() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class CashboxVersion_QueryRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion.QueryRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..aOM<$1.Err>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'err', subBuilder: $1.Err.create)
    ..aOM<$1.PageRes>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', subBuilder: $1.PageRes.create)
    ..pc<CashboxVersion_Model>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apk', $pb.PbFieldType.PM, subBuilder: CashboxVersion_Model.create)
    ..hasRequiredFields = false
  ;

  CashboxVersion_QueryRes._() : super();
  factory CashboxVersion_QueryRes({
    $1.Err err,
    $1.PageRes page,
    $core.Iterable<CashboxVersion_Model> apk,
  }) {
    final _result = create();
    if (err != null) {
      _result.err = err;
    }
    if (page != null) {
      _result.page = page;
    }
    if (apk != null) {
      _result.apk.addAll(apk);
    }
    return _result;
  }
  factory CashboxVersion_QueryRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion_QueryRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion_QueryRes clone() => CashboxVersion_QueryRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion_QueryRes copyWith(void Function(CashboxVersion_QueryRes) updates) => super.copyWith((message) => updates(message as CashboxVersion_QueryRes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_QueryRes create() => CashboxVersion_QueryRes._();
  CashboxVersion_QueryRes createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion_QueryRes> createRepeated() => $pb.PbList<CashboxVersion_QueryRes>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion_QueryRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion_QueryRes>(create);
  static CashboxVersion_QueryRes _defaultInstance;

  @$pb.TagNumber(1)
  $1.Err get err => $_getN(0);
  @$pb.TagNumber(1)
  set err($1.Err v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => clearField(1);
  @$pb.TagNumber(1)
  $1.Err ensureErr() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.PageRes get page => $_getN(1);
  @$pb.TagNumber(2)
  set page($1.PageRes v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
  @$pb.TagNumber(2)
  $1.PageRes ensurePage() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<CashboxVersion_Model> get apk => $_getList(2);
}

class CashboxVersion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CashboxVersion', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rpc_face'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CashboxVersion._() : super();
  factory CashboxVersion() => create();
  factory CashboxVersion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CashboxVersion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CashboxVersion clone() => CashboxVersion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CashboxVersion copyWith(void Function(CashboxVersion) updates) => super.copyWith((message) => updates(message as CashboxVersion)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CashboxVersion create() => CashboxVersion._();
  CashboxVersion createEmptyInstance() => create();
  static $pb.PbList<CashboxVersion> createRepeated() => $pb.PbList<CashboxVersion>();
  @$core.pragma('dart2js:noInline')
  static CashboxVersion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashboxVersion>(create);
  static CashboxVersion _defaultInstance;
}

