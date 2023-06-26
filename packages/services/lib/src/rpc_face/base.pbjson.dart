//
//  Generated code. Do not modify.
//  source: base.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errDescriptor instead')
const Err$json = {
  '1': 'Err',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 3, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Err`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errDescriptor = $convert.base64Decode(
    'CgNFcnISEgoEY29kZRgBIAEoA1IEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use pairDescriptor instead')
const Pair$json = {
  '1': 'Pair',
  '2': [
    {'1': 'Key', '3': 1, '4': 1, '5': 9, '10': 'Key'},
    {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

/// Descriptor for `Pair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairDescriptor = $convert.base64Decode(
    'CgRQYWlyEhAKA0tleRgBIAEoCVIDS2V5EhQKBVZhbHVlGAIgASgJUgVWYWx1ZQ==');

@$core.Deprecated('Use rpcModelBaseDescriptor instead')
const RpcModelBase$json = {
  '1': 'RpcModelBase',
  '2': [
    {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    {'1': 'UpdateTime', '3': 2, '4': 1, '5': 3, '10': 'UpdateTime'},
    {'1': 'CreateTime', '3': 3, '4': 1, '5': 3, '10': 'CreateTime'},
    {'1': 'OptimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'OptimisticLockVersion'},
  ],
};

/// Descriptor for `RpcModelBase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcModelBaseDescriptor = $convert.base64Decode(
    'CgxScGNNb2RlbEJhc2USDgoCSWQYASABKAlSAklkEh4KClVwZGF0ZVRpbWUYAiABKANSClVwZG'
    'F0ZVRpbWUSHgoKQ3JlYXRlVGltZRgDIAEoA1IKQ3JlYXRlVGltZRI0ChVPcHRpbWlzdGljTG9j'
    'a1ZlcnNpb24YBCABKANSFU9wdGltaXN0aWNMb2NrVmVyc2lvbg==');

@$core.Deprecated('Use languageValueDescriptor instead')
const LanguageValue$json = {
  '1': 'LanguageValue',
  '2': [
    {'1': 'LanguageId', '3': 1, '4': 1, '5': 9, '10': 'LanguageId'},
    {'1': 'Value', '3': 2, '4': 1, '5': 9, '10': 'Value'},
  ],
};

/// Descriptor for `LanguageValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languageValueDescriptor = $convert.base64Decode(
    'Cg1MYW5ndWFnZVZhbHVlEh4KCkxhbmd1YWdlSWQYASABKAlSCkxhbmd1YWdlSWQSFAoFVmFsdW'
    'UYAiABKAlSBVZhbHVl');

@$core.Deprecated('Use languagesDescriptor instead')
const Languages$json = {
  '1': 'Languages',
  '2': [
    {'1': 'DefaultValue', '3': 1, '4': 1, '5': 9, '10': 'DefaultValue'},
    {'1': 'Values', '3': 2, '4': 3, '5': 11, '6': '.rpc_face.LanguageValue', '10': 'Values'},
  ],
};

/// Descriptor for `Languages`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languagesDescriptor = $convert.base64Decode(
    'CglMYW5ndWFnZXMSIgoMRGVmYXVsdFZhbHVlGAEgASgJUgxEZWZhdWx0VmFsdWUSLwoGVmFsdW'
    'VzGAIgAygLMhcucnBjX2ZhY2UuTGFuZ3VhZ2VWYWx1ZVIGVmFsdWVz');

@$core.Deprecated('Use pageReqDescriptor instead')
const PageReq$json = {
  '1': 'PageReq',
  '2': [
    {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `PageReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageReqDescriptor = $convert.base64Decode(
    'CgdQYWdlUmVxEhoKCHBhZ2VTaXplGAEgASgFUghwYWdlU2l6ZRISCgRwYWdlGAIgASgFUgRwYW'
    'dl');

@$core.Deprecated('Use pageResDescriptor instead')
const PageRes$json = {
  '1': 'PageRes',
  '2': [
    {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `PageRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageResDescriptor = $convert.base64Decode(
    'CgdQYWdlUmVzEhoKCHBhZ2VTaXplGAEgASgFUghwYWdlU2l6ZRISCgRwYWdlGAIgASgFUgRwYW'
    'dlEhQKBXRvdGFsGAMgASgFUgV0b3RhbA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use errResDescriptor instead')
const ErrRes$json = {
  '1': 'ErrRes',
  '2': [
    {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `ErrRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errResDescriptor = $convert.base64Decode(
    'CgZFcnJSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');

@$core.Deprecated('Use deleteReqDescriptor instead')
const DeleteReq$json = {
  '1': 'DeleteReq',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
  ],
};

/// Descriptor for `DeleteReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReqDescriptor = $convert.base64Decode(
    'CglEZWxldGVSZXESEAoDaWRzGAEgAygJUgNpZHM=');

@$core.Deprecated('Use deleteResDescriptor instead')
const DeleteRes$json = {
  '1': 'DeleteRes',
  '2': [
    {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `DeleteRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteResDescriptor = $convert.base64Decode(
    'CglEZWxldGVSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');

@$core.Deprecated('Use recordStatusReqDescriptor instead')
const RecordStatusReq$json = {
  '1': 'RecordStatusReq',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `RecordStatusReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordStatusReqDescriptor = $convert.base64Decode(
    'Cg9SZWNvcmRTdGF0dXNSZXESEAoDaWRzGAEgAygJUgNpZHMSFgoGc3RhdHVzGAIgASgJUgZzdG'
    'F0dXM=');

@$core.Deprecated('Use recordStatusResDescriptor instead')
const RecordStatusRes$json = {
  '1': 'RecordStatusRes',
  '2': [
    {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `RecordStatusRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordStatusResDescriptor = $convert.base64Decode(
    'Cg9SZWNvcmRTdGF0dXNSZXMSHwoDZXJyGAEgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');

@$core.Deprecated('Use queryReqDescriptor instead')
const QueryReq$json = {
  '1': 'QueryReq',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

/// Descriptor for `QueryReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReqDescriptor = $convert.base64Decode(
    'CghRdWVyeVJlcRIlCgRwYWdlGAEgASgLMhEucnBjX2ZhY2UuUGFnZVJlcVIEcGFnZQ==');

@$core.Deprecated('Use getByIdReqDescriptor instead')
const GetByIdReq$json = {
  '1': 'GetByIdReq',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetByIdReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getByIdReqDescriptor = $convert.base64Decode(
    'CgpHZXRCeUlkUmVxEg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use appKeyDescriptor instead')
const AppKey$json = {
  '1': 'AppKey',
  '2': [
    {'1': 'pubKey', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'priKey', '3': 2, '4': 1, '5': 9, '10': 'priKey'},
    {'1': 'keyType', '3': 3, '4': 1, '5': 9, '10': 'keyType'},
    {'1': 'keyAuthType', '3': 4, '4': 1, '5': 9, '10': 'keyAuthType'},
    {'1': 'value', '3': 5, '4': 1, '5': 3, '10': 'value'},
  ],
};

/// Descriptor for `AppKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appKeyDescriptor = $convert.base64Decode(
    'CgZBcHBLZXkSFgoGcHViS2V5GAEgASgJUgZwdWJLZXkSFgoGcHJpS2V5GAIgASgJUgZwcmlLZX'
    'kSGAoHa2V5VHlwZRgDIAEoCVIHa2V5VHlwZRIgCgtrZXlBdXRoVHlwZRgEIAEoCVILa2V5QXV0'
    'aFR5cGUSFAoFdmFsdWUYBSABKANSBXZhbHVl');

@$core.Deprecated('Use basicClientReqDescriptor instead')
const BasicClientReq$json = {
  '1': 'BasicClientReq',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'deviceId', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'cashboxType', '3': 3, '4': 1, '5': 9, '10': 'cashboxType'},
    {'1': 'cashboxVersion', '3': 4, '4': 1, '5': 9, '10': 'cashboxVersion'},
    {'1': 'platformType', '3': 5, '4': 1, '5': 9, '10': 'platformType'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `BasicClientReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List basicClientReqDescriptor = $convert.base64Decode(
    'Cg5CYXNpY0NsaWVudFJlcRIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZRIaCghkZXZpY2'
    'VJZBgCIAEoCVIIZGV2aWNlSWQSIAoLY2FzaGJveFR5cGUYAyABKAlSC2Nhc2hib3hUeXBlEiYK'
    'DmNhc2hib3hWZXJzaW9uGAQgASgJUg5jYXNoYm94VmVyc2lvbhIiCgxwbGF0Zm9ybVR5cGUYBS'
    'ABKAlSDHBsYXRmb3JtVHlwZRIcCgl0aW1lc3RhbXAYBiABKANSCXRpbWVzdGFtcA==');

