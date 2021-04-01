///
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use errDescriptor instead')
const Err$json = const {
  '1': 'Err',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 3, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Err`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errDescriptor = $convert.base64Decode('CgNFcnISEgoEY29kZRgBIAEoA1IEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use pairDescriptor instead')
const Pair$json = const {
  '1': 'Pair',
  '2': const [
    const {'1': 'Key', '3': 1, '4': 1, '5': 9, '10': 'Key'},
    const {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

/// Descriptor for `Pair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairDescriptor = $convert.base64Decode('CgRQYWlyEhAKA0tleRgBIAEoCVIDS2V5EhQKBVZhbHVlGAIgASgJUgVWYWx1ZQ==');
@$core.Deprecated('Use rpcModelBaseDescriptor instead')
const RpcModelBase$json = const {
  '1': 'RpcModelBase',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'UpdateTime', '3': 2, '4': 1, '5': 3, '10': 'UpdateTime'},
    const {'1': 'CreateTime', '3': 3, '4': 1, '5': 3, '10': 'CreateTime'},
    const {'1': 'OptimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'OptimisticLockVersion'},
  ],
};

/// Descriptor for `RpcModelBase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcModelBaseDescriptor = $convert.base64Decode('CgxScGNNb2RlbEJhc2USDgoCSWQYASABKAlSAklkEh4KClVwZGF0ZVRpbWUYAiABKANSClVwZGF0ZVRpbWUSHgoKQ3JlYXRlVGltZRgDIAEoA1IKQ3JlYXRlVGltZRI0ChVPcHRpbWlzdGljTG9ja1ZlcnNpb24YBCABKANSFU9wdGltaXN0aWNMb2NrVmVyc2lvbg==');
@$core.Deprecated('Use languageValueDescriptor instead')
const LanguageValue$json = const {
  '1': 'LanguageValue',
  '2': const [
    const {'1': 'LanguageId', '3': 1, '4': 1, '5': 9, '10': 'LanguageId'},
    const {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

/// Descriptor for `LanguageValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languageValueDescriptor = $convert.base64Decode('Cg1MYW5ndWFnZVZhbHVlEh4KCkxhbmd1YWdlSWQYASABKAlSCkxhbmd1YWdlSWQSFAoFVmFsdWUYAiABKAlSBVZhbHVl');
@$core.Deprecated('Use languagesDescriptor instead')
const Languages$json = const {
  '1': 'Languages',
  '2': const [
    const {'1': 'DefaultValue', '3': 1, '4': 1, '5': 9, '10': 'DefaultValue'},
    const {'1': 'Values', '3': 2, '4': 3, '5': 11, '6': '.rpc_face.LanguageValue', '10': 'Values'},
  ],
};

/// Descriptor for `Languages`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languagesDescriptor = $convert.base64Decode('CglMYW5ndWFnZXMSIgoMRGVmYXVsdFZhbHVlGAEgASgJUgxEZWZhdWx0VmFsdWUSLwoGVmFsdWVzGAIgAygLMhcucnBjX2ZhY2UuTGFuZ3VhZ2VWYWx1ZVIGVmFsdWVz');
@$core.Deprecated('Use pageReqDescriptor instead')
const PageReq$json = const {
  '1': 'PageReq',
  '2': const [
    const {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `PageReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageReqDescriptor = $convert.base64Decode('CgdQYWdlUmVxEhoKCHBhZ2VTaXplGAEgASgFUghwYWdlU2l6ZRISCgRwYWdlGAIgASgFUgRwYWdl');
@$core.Deprecated('Use pageResDescriptor instead')
const PageRes$json = const {
  '1': 'PageRes',
  '2': const [
    const {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `PageRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageResDescriptor = $convert.base64Decode('CgdQYWdlUmVzEhoKCHBhZ2VTaXplGAEgASgFUghwYWdlU2l6ZRISCgRwYWdlGAIgASgFUgRwYWdlEhQKBXRvdGFsGAMgASgFUgV0b3RhbA==');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use errResDescriptor instead')
const ErrRes$json = const {
  '1': 'ErrRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `ErrRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errResDescriptor = $convert.base64Decode('CgZFcnJSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
@$core.Deprecated('Use deleteReqDescriptor instead')
const DeleteReq$json = const {
  '1': 'DeleteReq',
  '2': const [
    const {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
  ],
};

/// Descriptor for `DeleteReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReqDescriptor = $convert.base64Decode('CglEZWxldGVSZXESEAoDaWRzGAEgAygJUgNpZHM=');
@$core.Deprecated('Use deleteResDescriptor instead')
const DeleteRes$json = const {
  '1': 'DeleteRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `DeleteRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteResDescriptor = $convert.base64Decode('CglEZWxldGVSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
@$core.Deprecated('Use recordStatusReqDescriptor instead')
const RecordStatusReq$json = const {
  '1': 'RecordStatusReq',
  '2': const [
    const {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `RecordStatusReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordStatusReqDescriptor = $convert.base64Decode('Cg9SZWNvcmRTdGF0dXNSZXESEAoDaWRzGAEgAygJUgNpZHMSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use recordStatusResDescriptor instead')
const RecordStatusRes$json = const {
  '1': 'RecordStatusRes',
  '2': const [
    const {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `RecordStatusRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordStatusResDescriptor = $convert.base64Decode('Cg9SZWNvcmRTdGF0dXNSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
@$core.Deprecated('Use queryReqDescriptor instead')
const QueryReq$json = const {
  '1': 'QueryReq',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

/// Descriptor for `QueryReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReqDescriptor = $convert.base64Decode('CghRdWVyeVJlcRIlCgRwYWdlGAEgASgLMhEucnBjX2ZhY2UuUGFnZVJlcVIEcGFnZQ==');
@$core.Deprecated('Use getByIdReqDescriptor instead')
const GetByIdReq$json = const {
  '1': 'GetByIdReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetByIdReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdReqDescriptor = $convert.base64Decode('CgpHZXRCeUlkUmVxEg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use appKeyDescriptor instead')
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

/// Descriptor for `AppKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appKeyDescriptor = $convert.base64Decode('CgZBcHBLZXkSFgoGcHViS2V5GAEgASgJUgZwdWJLZXkSFgoGcHJpS2V5GAIgASgJUgZwcmlLZXkSGAoHa2V5VHlwZRgDIAEoCVIHa2V5VHlwZRIgCgtrZXlBdXRoVHlwZRgEIAEoCVILa2V5QXV0aFR5cGUSFAoFdmFsdWUYBSABKANSBXZhbHVl');
@$core.Deprecated('Use basicClientReqDescriptor instead')
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

/// Descriptor for `BasicClientReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basicClientReqDescriptor = $convert.base64Decode('Cg5CYXNpY0NsaWVudFJlcRIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZRIaCghkZXZpY2VJZBgCIAEoCVIIZGV2aWNlSWQSIAoLY2FzaGJveFR5cGUYAyABKAlSC2Nhc2hib3hUeXBlEiYKDmNhc2hib3hWZXJzaW9uGAQgASgJUg5jYXNoYm94VmVyc2lvbhIiCgxwbGF0Zm9ybVR5cGUYBSABKAlSDHBsYXRmb3JtVHlwZRIcCgl0aW1lc3RhbXAYBiABKANSCXRpbWVzdGFtcA==');
