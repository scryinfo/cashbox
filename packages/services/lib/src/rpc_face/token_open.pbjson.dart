//
//  Generated code. Do not modify.
//  source: token_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use tokenSharedOpenDescriptor instead')
const TokenSharedOpen$json = {
  '1': 'TokenSharedOpen',
  '2': [
    {'1': 'Symbol', '3': 1, '4': 1, '5': 9, '10': 'Symbol'},
    {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
    {'1': 'Publisher', '3': 3, '4': 1, '5': 9, '10': 'Publisher'},
    {'1': 'Project', '3': 4, '4': 1, '5': 9, '10': 'Project'},
    {'1': 'LogoUrl', '3': 5, '4': 1, '5': 9, '10': 'LogoUrl'},
    {'1': 'LogoBytes', '3': 6, '4': 1, '5': 9, '10': 'LogoBytes'},
    {'1': 'ChainType', '3': 7, '4': 1, '5': 9, '10': 'ChainType'},
    {'1': 'Mark', '3': 8, '4': 1, '5': 9, '10': 'Mark'},
    {'1': 'TokenId', '3': 9, '4': 1, '5': 9, '10': 'TokenId'},
    {'1': 'NetType', '3': 10, '4': 1, '5': 9, '10': 'NetType'},
  ],
};

/// Descriptor for `TokenSharedOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenSharedOpenDescriptor = $convert.base64Decode(
    'Cg9Ub2tlblNoYXJlZE9wZW4SFgoGU3ltYm9sGAEgASgJUgZTeW1ib2wSEgoETmFtZRgCIAEoCV'
    'IETmFtZRIcCglQdWJsaXNoZXIYAyABKAlSCVB1Ymxpc2hlchIYCgdQcm9qZWN0GAQgASgJUgdQ'
    'cm9qZWN0EhgKB0xvZ29VcmwYBSABKAlSB0xvZ29VcmwSHAoJTG9nb0J5dGVzGAYgASgJUglMb2'
    'dvQnl0ZXMSHAoJQ2hhaW5UeXBlGAcgASgJUglDaGFpblR5cGUSEgoETWFyaxgIIAEoCVIETWFy'
    'axIYCgdUb2tlbklkGAkgASgJUgdUb2tlbklkEhgKB05ldFR5cGUYCiABKAlSB05ldFR5cGU=');

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen$json = {
  '1': 'EthTokenOpen',
  '3': [EthTokenOpen_Token$json, EthTokenOpen_QueryReq$json, EthTokenOpen_QueryRes$json],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_Token$json = {
  '1': 'Token',
  '2': [
    {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    {'1': 'TokenShardId', '3': 2, '4': 1, '5': 9, '10': 'TokenShardId'},
    {'1': 'TokenShared', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.TokenSharedOpen', '10': 'TokenShared'},
    {'1': 'Decimal', '3': 4, '4': 1, '5': 5, '10': 'Decimal'},
    {'1': 'GasLimit', '3': 5, '4': 1, '5': 3, '10': 'GasLimit'},
    {'1': 'GasPrice', '3': 8, '4': 1, '5': 3, '10': 'GasPrice'},
    {'1': 'Contract', '3': 6, '4': 1, '5': 9, '10': 'Contract'},
    {'1': 'Position', '3': 7, '4': 1, '5': 1, '10': 'Position'},
  ],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_QueryReq$json = {
  '1': 'QueryReq',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.BasicClientReq', '10': 'info'},
    {'1': 'isDefault', '3': 2, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'page', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

@$core.Deprecated('Use ethTokenOpenDescriptor instead')
const EthTokenOpen_QueryRes$json = {
  '1': 'QueryRes',
  '2': [
    {'1': 'tokens', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.EthTokenOpen.Token', '10': 'tokens'},
    {'1': 'page', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.PageRes', '10': 'page'},
    {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `EthTokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ethTokenOpenDescriptor = $convert.base64Decode(
    'CgxFdGhUb2tlbk9wZW4aggIKBVRva2VuEg4KAklkGAEgASgJUgJJZBIiCgxUb2tlblNoYXJkSW'
    'QYAiABKAlSDFRva2VuU2hhcmRJZBI7CgtUb2tlblNoYXJlZBgDIAEoCzIZLnJwY19mYWNlLlRv'
    'a2VuU2hhcmVkT3BlblILVG9rZW5TaGFyZWQSGAoHRGVjaW1hbBgEIAEoBVIHRGVjaW1hbBIaCg'
    'hHYXNMaW1pdBgFIAEoA1IIR2FzTGltaXQSGgoIR2FzUHJpY2UYCCABKANSCEdhc1ByaWNlEhoK'
    'CENvbnRyYWN0GAYgASgJUghDb250cmFjdBIaCghQb3NpdGlvbhgHIAEoAVIIUG9zaXRpb24afQ'
    'oIUXVlcnlSZXESLAoEaW5mbxgBIAEoCzIYLnJwY19mYWNlLkJhc2ljQ2xpZW50UmVxUgRpbmZv'
    'EhwKCWlzRGVmYXVsdBgCIAEoCFIJaXNEZWZhdWx0EiUKBHBhZ2UYAyABKAsyES5ycGNfZmFjZS'
    '5QYWdlUmVxUgRwYWdlGogBCghRdWVyeVJlcxI0CgZ0b2tlbnMYASADKAsyHC5ycGNfZmFjZS5F'
    'dGhUb2tlbk9wZW4uVG9rZW5SBnRva2VucxIlCgRwYWdlGAIgASgLMhEucnBjX2ZhY2UuUGFnZV'
    'Jlc1IEcGFnZRIfCgNlcnIYAyABKAsyDS5ycGNfZmFjZS5FcnJSA2Vycg==');

@$core.Deprecated('Use eeeTokenOpenDescriptor instead')
const EeeTokenOpen$json = {
  '1': 'EeeTokenOpen',
  '3': [EeeTokenOpen_Token$json, EeeTokenOpen_QueryReq$json, EeeTokenOpen_QueryRes$json],
};

@$core.Deprecated('Use eeeTokenOpenDescriptor instead')
const EeeTokenOpen_Token$json = {
  '1': 'Token',
  '2': [
    {'1': 'Id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    {'1': 'TokenShardId', '3': 2, '4': 1, '5': 9, '10': 'TokenShardId'},
    {'1': 'TokenShared', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.TokenSharedOpen', '10': 'TokenShared'},
    {'1': 'Decimal', '3': 4, '4': 1, '5': 5, '10': 'Decimal'},
    {'1': 'GasLimit', '3': 5, '4': 1, '5': 3, '10': 'GasLimit'},
    {'1': 'GasPrice', '3': 8, '4': 1, '5': 3, '10': 'GasPrice'},
    {'1': 'Contract', '3': 6, '4': 1, '5': 9, '10': 'Contract'},
    {'1': 'Position', '3': 7, '4': 1, '5': 1, '10': 'Position'},
  ],
};

@$core.Deprecated('Use eeeTokenOpenDescriptor instead')
const EeeTokenOpen_QueryReq$json = {
  '1': 'QueryReq',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.BasicClientReq', '10': 'info'},
    {'1': 'isDefault', '3': 2, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'page', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.PageReq', '10': 'page'},
  ],
};

@$core.Deprecated('Use eeeTokenOpenDescriptor instead')
const EeeTokenOpen_QueryRes$json = {
  '1': 'QueryRes',
  '2': [
    {'1': 'tokens', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.EeeTokenOpen.Token', '10': 'tokens'},
    {'1': 'page', '3': 2, '4': 1, '5': 11, '6': '.rpc_face.PageRes', '10': 'page'},
    {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `EeeTokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eeeTokenOpenDescriptor = $convert.base64Decode(
    'CgxFZWVUb2tlbk9wZW4aggIKBVRva2VuEg4KAklkGAEgASgJUgJJZBIiCgxUb2tlblNoYXJkSW'
    'QYAiABKAlSDFRva2VuU2hhcmRJZBI7CgtUb2tlblNoYXJlZBgDIAEoCzIZLnJwY19mYWNlLlRv'
    'a2VuU2hhcmVkT3BlblILVG9rZW5TaGFyZWQSGAoHRGVjaW1hbBgEIAEoBVIHRGVjaW1hbBIaCg'
    'hHYXNMaW1pdBgFIAEoA1IIR2FzTGltaXQSGgoIR2FzUHJpY2UYCCABKANSCEdhc1ByaWNlEhoK'
    'CENvbnRyYWN0GAYgASgJUghDb250cmFjdBIaCghQb3NpdGlvbhgHIAEoAVIIUG9zaXRpb24afQ'
    'oIUXVlcnlSZXESLAoEaW5mbxgBIAEoCzIYLnJwY19mYWNlLkJhc2ljQ2xpZW50UmVxUgRpbmZv'
    'EhwKCWlzRGVmYXVsdBgCIAEoCFIJaXNEZWZhdWx0EiUKBHBhZ2UYAyABKAsyES5ycGNfZmFjZS'
    '5QYWdlUmVxUgRwYWdlGogBCghRdWVyeVJlcxI0CgZ0b2tlbnMYASADKAsyHC5ycGNfZmFjZS5F'
    'ZWVUb2tlbk9wZW4uVG9rZW5SBnRva2VucxIlCgRwYWdlGAIgASgLMhEucnBjX2ZhY2UuUGFnZV'
    'Jlc1IEcGFnZRIfCgNlcnIYAyABKAsyDS5ycGNfZmFjZS5FcnJSA2Vycg==');

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen$json = {
  '1': 'TokenOpen',
  '3': [TokenOpen_Price$json, TokenOpen_Rate$json, TokenOpen_PriceRateRes$json],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_Price$json = {
  '1': 'Price',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'rank', '3': 2, '4': 1, '5': 9, '10': 'rank'},
    {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'supply', '3': 5, '4': 1, '5': 9, '10': 'supply'},
    {'1': 'maxSupply', '3': 6, '4': 1, '5': 9, '10': 'maxSupply'},
    {'1': 'marketCapUsd', '3': 7, '4': 1, '5': 9, '10': 'marketCapUsd'},
    {'1': 'volumeUsd24Hr', '3': 8, '4': 1, '5': 9, '10': 'volumeUsd24Hr'},
    {'1': 'priceUsd', '3': 9, '4': 1, '5': 9, '10': 'priceUsd'},
    {'1': 'changePercent24Hr', '3': 10, '4': 1, '5': 9, '10': 'changePercent24Hr'},
    {'1': 'vwap24Hr', '3': 11, '4': 1, '5': 9, '10': 'vwap24Hr'},
    {'1': 'explorer', '3': 12, '4': 1, '5': 9, '10': 'explorer'},
  ],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_Rate$json = {
  '1': 'Rate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

@$core.Deprecated('Use tokenOpenDescriptor instead')
const TokenOpen_PriceRateRes$json = {
  '1': 'PriceRateRes',
  '2': [
    {'1': 'prices', '3': 1, '4': 3, '5': 11, '6': '.rpc_face.TokenOpen.Price', '10': 'prices'},
    {'1': 'rates', '3': 2, '4': 3, '5': 11, '6': '.rpc_face.TokenOpen.Rate', '10': 'rates'},
    {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `TokenOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenOpenDescriptor = $convert.base64Decode(
    'CglUb2tlbk9wZW4a2QIKBVByaWNlEg4KAmlkGAEgASgJUgJpZBISCgRyYW5rGAIgASgJUgRyYW'
    '5rEhYKBnN5bWJvbBgDIAEoCVIGc3ltYm9sEhIKBG5hbWUYBCABKAlSBG5hbWUSFgoGc3VwcGx5'
    'GAUgASgJUgZzdXBwbHkSHAoJbWF4U3VwcGx5GAYgASgJUgltYXhTdXBwbHkSIgoMbWFya2V0Q2'
    'FwVXNkGAcgASgJUgxtYXJrZXRDYXBVc2QSJAoNdm9sdW1lVXNkMjRIchgIIAEoCVINdm9sdW1l'
    'VXNkMjRIchIaCghwcmljZVVzZBgJIAEoCVIIcHJpY2VVc2QSLAoRY2hhbmdlUGVyY2VudDI0SH'
    'IYCiABKAlSEWNoYW5nZVBlcmNlbnQyNEhyEhoKCHZ3YXAyNEhyGAsgASgJUgh2d2FwMjRIchIa'
    'CghleHBsb3JlchgMIAEoCVIIZXhwbG9yZXIaMAoEUmF0ZRISCgRuYW1lGAEgASgJUgRuYW1lEh'
    'QKBXZhbHVlGAIgASgBUgV2YWx1ZRqSAQoMUHJpY2VSYXRlUmVzEjEKBnByaWNlcxgBIAMoCzIZ'
    'LnJwY19mYWNlLlRva2VuT3Blbi5QcmljZVIGcHJpY2VzEi4KBXJhdGVzGAIgAygLMhgucnBjX2'
    'ZhY2UuVG9rZW5PcGVuLlJhdGVSBXJhdGVzEh8KA2VychgDIAEoCzINLnJwY19mYWNlLkVyclID'
    'ZXJy');

