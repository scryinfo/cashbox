///
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.12
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
    const {'1': 'TokenId', '3': 9, '4': 1, '5': 9, '10': 'TokenId'},
    const {'1': 'NetType', '3': 10, '4': 1, '5': 9, '10': 'NetType'},
  ],
};

/// Descriptor for `TokenSharedOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenSharedOpenDescriptor = $convert.base64Decode('Cg9Ub2tlblNoYXJlZE9wZW4SFgoGU3ltYm9sGAEgASgJUgZTeW1ib2wSEgoETmFtZRgCIAEoCVIETmFtZRIcCglQdWJsaXNoZXIYAyABKAlSCVB1Ymxpc2hlchIYCgdQcm9qZWN0GAQgASgJUgdQcm9qZWN0EhgKB0xvZ29VcmwYBSABKAlSB0xvZ29VcmwSHAoJTG9nb0J5dGVzGAYgASgJUglMb2dvQnl0ZXMSHAoJQ2hhaW5UeXBlGAcgASgJUglDaGFpblR5cGUSEgoETWFyaxgIIAEoCVIETWFyaxIYCgdUb2tlbklkGAkgASgJUgdUb2tlbklkEhgKB05ldFR5cGUYCiABKAlSB05ldFR5cGU=');
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
    const {'1': 'TokenShardId', '3': 2, '4': 1, '5': 9, '10': 'TokenShardId'},
    const {'1': 'TokenShared', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.TokenSharedOpen', '10': 'TokenShared'},
    const {'1': 'Decimal', '3': 4, '4': 1, '5': 5, '10': 'Decimal'},
    const {'1': 'GasLimit', '3': 5, '4': 1, '5': 3, '10': 'GasLimit'},
    const {'1': 'Contract', '3': 6, '4': 1, '5': 9, '10': 'Contract'},
    const {'1': 'Position', '3': 7, '4': 1, '5': 1, '10': 'Position'},
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
final $typed_data.Uint8List ethTokenOpenDescriptor = $convert.base64Decode('CgxFdGhUb2tlbk9wZW4a5gEKBVRva2VuEg4KAklkGAEgASgJUgJJZBIiCgxUb2tlblNoYXJkSWQYAiABKAlSDFRva2VuU2hhcmRJZBI7CgtUb2tlblNoYXJlZBgDIAEoCzIZLnJwY19mYWNlLlRva2VuU2hhcmVkT3BlblILVG9rZW5TaGFyZWQSGAoHRGVjaW1hbBgEIAEoBVIHRGVjaW1hbBIaCghHYXNMaW1pdBgFIAEoA1IIR2FzTGltaXQSGgoIQ29udHJhY3QYBiABKAlSCENvbnRyYWN0EhoKCFBvc2l0aW9uGAcgASgBUghQb3NpdGlvbhp9CghRdWVyeVJlcRIsCgRpbmZvGAEgASgLMhgucnBjX2ZhY2UuQmFzaWNDbGllbnRSZXFSBGluZm8SHAoJaXNEZWZhdWx0GAIgASgIUglpc0RlZmF1bHQSJQoEcGFnZRgDIAEoCzIRLnJwY19mYWNlLlBhZ2VSZXFSBHBhZ2UaiAEKCFF1ZXJ5UmVzEjQKBnRva2VucxgBIAMoCzIcLnJwY19mYWNlLkV0aFRva2VuT3Blbi5Ub2tlblIGdG9rZW5zEiUKBHBhZ2UYAiABKAsyES5ycGNfZmFjZS5QYWdlUmVzUgRwYWdlEh8KA2VychgDIAEoCzINLnJwY19mYWNlLkVyclIDZXJy');
@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen$json = const {
  '1': 'TokenOpen',
  '3': const [TokenOpen_Price$json, TokenOpen_Rate$json, TokenOpen_PriceRateRes$json],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_Price$json = const {
  '1': 'Price',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'rank', '3': 2, '4': 1, '5': 9, '10': 'rank'},
    const {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'supply', '3': 5, '4': 1, '5': 9, '10': 'supply'},
    const {'1': 'maxSupply', '3': 6, '4': 1, '5': 9, '10': 'maxSupply'},
    const {'1': 'marketCapUsd', '3': 7, '4': 1, '5': 9, '10': 'marketCapUsd'},
    const {'1': 'volumeUsd24Hr', '3': 8, '4': 1, '5': 9, '10': 'volumeUsd24Hr'},
    const {'1': 'priceUsd', '3': 9, '4': 1, '5': 9, '10': 'priceUsd'},
    const {'1': 'changePercent24Hr', '3': 10, '4': 1, '5': 9, '10': 'changePercent24Hr'},
    const {'1': 'vwap24Hr', '3': 11, '4': 1, '5': 9, '10': 'vwap24Hr'},
    const {'1': 'explorer', '3': 12, '4': 1, '5': 9, '10': 'explorer'},
  ],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_Rate$json = const {
  '1': 'Rate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_PriceRateRes$json = const {
  '1': 'PriceRateRes',
  '2': const [
    const {'1': 'prices', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.TokenOpen.Price', '10': 'prices'},
    const {'1': 'rates', '3': 2, '4': 3, '5': 11, '6': '.rpc_face.TokenOpen.Rate', '10': 'rates'},
    const {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `TokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenOpenDescriptor = $convert.base64Decode('CglUb2tlbk9wZW4a2QIKBVByaWNlEg4KAmlkGAEgASgJUgJpZBISCgRyYW5rGAIgASgJUgRyYW5rEhYKBnN5bWJvbBgDIAEoCVIGc3ltYm9sEhIKBG5hbWUYBCABKAlSBG5hbWUSFgoGc3VwcGx5GAUgASgJUgZzdXBwbHkSHAoJbWF4U3VwcGx5GAYgASgJUgltYXhTdXBwbHkSIgoMbWFya2V0Q2FwVXNkGAcgASgJUgxtYXJrZXRDYXBVc2QSJAoNdm9sdW1lVXNkMjRIchgIIAEoCVINdm9sdW1lVXNkMjRIchIaCghwcmljZVVzZBgJIAEoCVIIcHJpY2VVc2QSLAoRY2hhbmdlUGVyY2VudDI0SHIYCiABKAlSEWNoYW5nZVBlcmNlbnQyNEhyEhoKCHZ3YXAyNEhyGAsgASgJUgh2d2FwMjRIchIaCghleHBsb3JlchgMIAEoCVIIZXhwbG9yZXIaMAoEUmF0ZRISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgBUgV2YWx1ZRqSAQoMUHJpY2VSYXRlUmVzEjEKBnByaWNlcxgBIAMoCzIZLnJwY19mYWNlLlRva2VuT3Blbi5QcmljZVIGcHJpY2VzEi4KBXJhdGVzGAIgAygLMhgucnBjX2ZhY2UuVG9rZW5PcGVuLlJhdGVSBXJhdGVzEh8KA2VychgDIAEoCzINLnJwY19mYWNlLkVyclIDZXJy');
