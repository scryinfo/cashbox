///
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use tokenSharedOpenDescriptor instead')
const TokenSharedOpen$json = const {
  '1': 'TokenSharedOpen',
  '2': const [
    const {'1': 'Symbol', '3': 1, '4': 1, '5': 9, '10': 'Symbol'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Publisher', '3': 3, '4': 1, '5': 9, '10': 'Publisher'},
    const {'1': 'Project', '3': 4, '4': 1, '5': 9, '10': 'Project'},
    const {'1': 'LogoUrl', '3': 5, '4': 1, '5': 9, '10': 'LogoUrl'},
    const {'1': 'LogoBytes', '3': 6, '4': 1, '5': 9, '10': 'LogoBytes'},
    const {'1': 'ChainType', '3': 7, '4': 1, '5': 9, '10': 'ChainType'},
    const {'1': 'Mark', '3': 8, '4': 1, '5': 9, '10': 'Mark'},
  ],
};

/// Descriptor for `TokenSharedOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenSharedOpenDescriptor = $convert.base64Decode('Cg9Ub2tlblNoYXJlZE9wZW4SFgoGU3ltYm9sGAEgASgJUgZTeW1ib2wSEgoETmFtZRgCIAEoCVIETmFtZRIcCglQdWJsaXNoZXIYAyABKAlSCVB1Ymxpc2hlchIYCgdQcm9qZWN0GAQgASgJUgdQcm9qZWN0EhgKB0xvZ29VcmwYBSABKAlSB0xvZ29VcmwSHAoJTG9nb0J5dGVzGAYgASgJUglMb2dvQnl0ZXMSHAoJQ2hhaW5UeXBlGAcgASgJUglDaGFpblR5cGUSEgoETWFyaxgIIAEoCVIETWFyaw==');
@$core.Deprecated('Use ethereumTokenOpenDescriptor instead')
const EthereumTokenOpen$json = const {
  '1': 'EthereumTokenOpen',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'TokenShared', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.TokenSharedOpen', '10': 'TokenShared'},
    const {'1': 'Decimal', '3': 3, '4': 1, '5': 5, '10': 'Decimal'},
    const {'1': 'GasLimit', '3': 4, '4': 1, '5': 3, '10': 'GasLimit'},
    const {'1': 'Contract', '3': 5, '4': 1, '5': 9, '10': 'Contract'},
  ],
};

/// Descriptor for `EthereumTokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ethereumTokenOpenDescriptor = $convert.base64Decode('ChFFdGhlcmV1bVRva2VuT3BlbhIOCgJJZBgBIAEoCVICSWQSOwoLVG9rZW5TaGFyZWQYAiABKAsyGS5ycGNfZmFjZS5Ub2tlblNoYXJlZE9wZW5SC1Rva2VuU2hhcmVkEhgKB0RlY2ltYWwYAyABKAVSB0RlY2ltYWwSGgoIR2FzTGltaXQYBCABKANSCEdhc0xpbWl0EhoKCENvbnRyYWN0GAUgASgJUghDb250cmFjdA==');
@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen$json = const {
  '1': 'EthTokenOpen',
  '3': const [EthTokenOpen_Token$json, EthTokenOpen_QueryReq$json, EthTokenOpen_QueryRes$json],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_Token$json = const {
  '1': 'Token',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'EthereumTokenId', '3': 2, '4': 1, '5': 9, '10': 'EthereumTokenId'},
    const {'1': 'EthereumToken', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.EthereumTokenOpen', '10': 'EthereumToken'},
    const {'1': 'Position', '3': 4, '4': 1, '5': 1, '10': 'Position'},
  ],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_QueryReq$json = const {
  '1': 'QueryReq',
  '2': const [
    const {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.BasicClientReq', '10': 'info'},
    const {'1': 'isDefault', '3': 2, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'page', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_QueryRes$json = const {
  '1': 'QueryRes',
  '2': const [
    const {'1': 'tokens', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.EthTokenOpen.Token', '10': 'tokens'},
    const {'1': 'page', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.PageRes', '10': 'page'},
    const {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `EthTokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ethTokenOpenDescriptor = $convert.base64Decode('CgxFdGhUb2tlbk9wZW4aoAEKBVRva2VuEg4KAklkGAEgASgJUgJJZBIoCg9FdGhlcmV1bVRva2VuSWQYAiABKAlSD0V0aGVyZXVtVG9rZW5JZBJBCg1FdGhlcmV1bVRva2VuGAMgASgLMhsucnBjX2ZhY2UuRXRoZXJldW1Ub2tlbk9wZW5SDUV0aGVyZXVtVG9rZW4SGgoIUG9zaXRpb24YBCABKAFSCFBvc2l0aW9uGn0KCFF1ZXJ5UmVxEiwKBGluZm8YASABKAsyGC5ycGNfZmFjZS5CYXNpY0NsaWVudFJlcVIEaW5mbxIcCglpc0RlZmF1bHQYAiABKAhSCWlzRGVmYXVsdBIlCgRwYWdlGAMgASgLMhEucnBjX2ZhY2UuUGFnZVJlcVIEcGFnZRqIAQoIUXVlcnlSZXMSNAoGdG9rZW5zGAEgAygLMhwucnBjX2ZhY2UuRXRoVG9rZW5PcGVuLlRva2VuUgZ0b2tlbnMSJQoEcGFnZRgCIAEoCzIRLnJwY19mYWNlLlBhZ2VSZXNSBHBhZ2USHwoDZXJyGAMgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen$json = const {
  '1': 'TokenOpen',
  '3': const [TokenOpen_PriceRateRes$json],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_PriceRateRes$json = const {
  '1': 'PriceRateRes',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `TokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenOpenDescriptor = $convert.base64Decode('CglUb2tlbk9wZW4aQwoMUHJpY2VSYXRlUmVzEhIKBGRhdGEYASABKAxSBGRhdGESHwoDZXJyGAMgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
