///
//  Generated code. Do not modify.
//  source: cashbox_version.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const FileMeta$json = const {
  '1': 'FileMeta',
  '2': const [
    const {'1': 'VersionDescription', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Languages', '10': 'VersionDescription'},
    const {'1': 'NewFunctions', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Languages', '10': 'NewFunctions'},
    const {'1': 'FixedBugs', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Languages', '10': 'FixedBugs'},
    const {'1': 'Author', '3': 4, '4': 1, '5': 11, '6': '.rpc_face.Languages', '10': 'Author'},
    const {'1': 'Compatibility', '3': 5, '4': 1, '5': 11, '6': '.rpc_face.Languages', '10': 'Compatibility'},
    const {'1': 'FileName', '3': 6, '4': 1, '5': 9, '10': 'FileName'},
    const {'1': 'FileSizeOfMB', '3': 7, '4': 1, '5': 3, '10': 'FileSizeOfMB'},
    const {'1': 'FileHash256', '3': 8, '4': 1, '5': 9, '10': 'FileHash256'},
    const {'1': 'DownloadLinkCloud', '3': 9, '4': 1, '5': 9, '10': 'DownloadLinkCloud'},
    const {'1': 'Signature', '3': 10, '4': 1, '5': 9, '10': 'Signature'},
  ],
};

const CashboxVersion$json = const {
  '1': 'CashboxVersion',
  '3': const [CashboxVersion_Model$json, CashboxVersion_SaveReq$json, CashboxVersion_SaveRes$json, CashboxVersion_GetByIdRes$json, CashboxVersion_QueryReq$json, CashboxVersion_QueryRes$json],
};

const CashboxVersion_Model$json = const {
  '1': 'Model',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'ReleaseTime', '3': 2, '4': 1, '5': 3, '10': 'ReleaseTime'},
    const {'1': 'ApkType', '3': 3, '4': 1, '5': 9, '10': 'ApkType'},
    const {'1': 'UpgradeType', '3': 4, '4': 1, '5': 9, '10': 'UpgradeType'},
    const {'1': 'VersionNumber', '3': 5, '4': 1, '5': 3, '10': 'VersionNumber'},
    const {'1': 'Version', '3': 6, '4': 1, '5': 9, '10': 'Version'},
    const {'1': 'OldVersions', '3': 7, '4': 3, '5': 9, '10': 'OldVersions'},
    const {'1': 'AppPlatformType', '3': 8, '4': 1, '5': 9, '10': 'AppPlatformType'},
    const {'1': 'RecordStatus', '3': 9, '4': 1, '5': 9, '10': 'RecordStatus'},
    const {'1': 'FileMeta', '3': 10, '4': 1, '5': 11, '6': '.rpc_face.FileMeta', '10': 'FileMeta'},
    const {'1': 'CreateTime', '3': 11, '4': 1, '5': 3, '10': 'CreateTime'},
    const {'1': 'UpdateTime', '3': 12, '4': 1, '5': 3, '10': 'UpdateTime'},
    const {'1': 'OptimisticLockVersion', '3': 13, '4': 1, '5': 3, '10': 'OptimisticLockVersion'},
  ],
};

const CashboxVersion_SaveReq$json = const {
  '1': 'SaveReq',
  '2': const [
    const {'1': 'cashboxVersion', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'cashboxVersion'},
  ],
};

const CashboxVersion_SaveRes$json = const {
  '1': 'SaveRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
    const {'1': 'cashboxVersion', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'cashboxVersion'},
  ],
};

const CashboxVersion_GetByIdRes$json = const {
  '1': 'GetByIdRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
    const {'1': 'apk', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'apk'},
  ],
};

const CashboxVersion_QueryReq$json = const {
  '1': 'QueryReq',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

const CashboxVersion_QueryRes$json = const {
  '1': 'QueryRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
    const {'1': 'page', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.PageRes', '10': 'page'},
    const {'1': 'apk', '3': 3, '4': 3, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'apk'},
  ],
};

