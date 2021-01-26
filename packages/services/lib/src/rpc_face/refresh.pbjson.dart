///
//  Generated code. Do not modify.
//  source: refresh.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const Refresh$json = const {
  '1': 'Refresh',
  '3': const [Refresh_ServiceMeta$json, Refresh_RefreshReq$json, Refresh_RefreshRes$json],
};

const Refresh_ServiceMeta$json = const {
  '1': 'ServiceMeta',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'updateTime', '3': 2, '4': 1, '5': 3, '10': 'updateTime'},
    const {'1': 'createTime', '3': 3, '4': 1, '5': 3, '10': 'createTime'},
    const {'1': 'optimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'optimisticLockVersion'},
    const {'1': 'host', '3': 5, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 6, '4': 1, '5': 3, '10': 'port'},
    const {'1': 'certificate', '3': 7, '4': 1, '5': 9, '10': 'certificate'},
    const {'1': 'serviceStatus', '3': 8, '4': 1, '5': 9, '10': 'serviceStatus'},
    const {'1': 'remark', '3': 9, '4': 1, '5': 9, '10': 'remark'},
  ],
};

const Refresh_RefreshReq$json = const {
  '1': 'RefreshReq',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    const {'1': 'appPlatformType', '3': 2, '4': 1, '5': 9, '10': 'appPlatformType'},
    const {'1': 'sign', '3': 3, '4': 1, '5': 9, '10': 'sign'},
  ],
};

const Refresh_RefreshRes$json = const {
  '1': 'RefreshRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
    const {'1': 'serviceMeta', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.Refresh.ServiceMeta', '10': 'serviceMeta'},
  ],
};

