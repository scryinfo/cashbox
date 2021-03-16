///
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Err$json = const {
  '1': 'Err',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 3, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const Pair$json = const {
  '1': 'Pair',
  '2': const [
    const {'1': 'Key', '3': 1, '4': 1, '5': 9, '10': 'Key'},
    const {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

const RpcModelBase$json = const {
  '1': 'RpcModelBase',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'UpdateTime', '3': 2, '4': 1, '5': 3, '10': 'UpdateTime'},
    const {'1': 'CreateTime', '3': 3, '4': 1, '5': 3, '10': 'CreateTime'},
    const {'1': 'OptimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'OptimisticLockVersion'},
  ],
};

const LanguageValue$json = const {
  '1': 'LanguageValue',
  '2': const [
    const {'1': 'LanguageId', '3': 1, '4': 1, '5': 9, '10': 'LanguageId'},
    const {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

const Languages$json = const {
  '1': 'Languages',
  '2': const [
    const {'1': 'DefaultValue', '3': 1, '4': 1, '5': 9, '10': 'DefaultValue'},
    const {'1': 'Values', '3': 2, '4': 3, '5': 11, '6': '.rpc_face.LanguageValue', '10': 'Values'},
  ],
};

const PageReq$json = const {
  '1': 'PageReq',
  '2': const [
    const {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
  ],
};

const PageRes$json = const {
  '1': 'PageRes',
  '2': const [
    const {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

const Empty$json = const {
  '1': 'Empty',
};

const ErrRes$json = const {
  '1': 'ErrRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const DeleteReq$json = const {
  '1': 'DeleteReq',
  '2': const [
    const {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
  ],
};

const DeleteRes$json = const {
  '1': 'DeleteRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const RecordStatusReq$json = const {
  '1': 'RecordStatusReq',
  '2': const [
    const {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

const RecordStatusRes$json = const {
  '1': 'RecordStatusRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

const QueryReq$json = const {
  '1': 'QueryReq',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

const GetByIdReq$json = const {
  '1': 'GetByIdReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const AppKey$json = const {
  '1': 'AppKey',
  '2': const [
    const {'1': 'pubKey', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    const {'1': 'priKey', '3': 2, '4': 1, '5': 9, '10': 'priKey'},
    const {'1': 'keyType', '3': 3, '4': 1, '5': 9, '10': 'keyType'},
    const {'1': 'keyAuthType', '3': 4, '4': 1, '5': 9, '10': 'keyAuthType'},
    const {'1': 'value', '3': 5, '4': 1, '5': 3, '10': 'value'},
  ],
};

const BasicClientReq$json = const {
  '1': 'BasicClientReq',
  '2': const [
    const {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    const {'1': 'deviceId', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'cashboxType', '3': 3, '4': 1, '5': 9, '10': 'cashboxType'},
    const {'1': 'cashboxVersion', '3': 4, '4': 1, '5': 9, '10': 'cashboxVersion'},
    const {'1': 'platformType', '3': 5, '4': 1, '5': 9, '10': 'platformType'},
    const {'1': 'timestamp', '3': 6, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

