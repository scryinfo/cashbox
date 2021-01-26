///
//  Generated code. Do not modify.
//  source: cache.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const CacheKeyReq$json = const {
  '1': 'CacheKeyReq',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
  ],
};

const UpdateCacheRes$json = const {
  '1': 'UpdateCacheRes',
  '2': const [
    const {'1': 'isUpdate', '3': 1, '4': 1, '5': 8, '10': 'isUpdate'},
    const {'1': 'err', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const VerifySignatureReq$json = const {
  '1': 'VerifySignatureReq',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.CacheKeyReq', '10': 'key'},
    const {'1': 'clientSignature', '3': 2, '4': 1, '5': 9, '10': 'clientSignature'},
  ],
};

const VerifySignatureRes$json = const {
  '1': 'VerifySignatureRes',
  '2': const [
    const {'1': 'validity', '3': 1, '4': 1, '5': 8, '10': 'validity'},
    const {'1': 'err', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const LatestApkRes$json = const {
  '1': 'LatestApkRes',
  '2': const [
    const {'1': 'cashboxVersion', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'cashboxVersion'},
    const {'1': 'err', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const AllApkRes$json = const {
  '1': 'AllApkRes',
  '2': const [
    const {'1': 'cashboxVersions', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.CashboxVersion.Model', '10': 'cashboxVersions'},
    const {'1': 'err', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const AppConfigRes$json = const {
  '1': 'AppConfigRes',
  '2': const [
    const {'1': 'conf', '3': 1, '4': 1, '5': 9, '10': 'conf'},
    const {'1': 'err', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

