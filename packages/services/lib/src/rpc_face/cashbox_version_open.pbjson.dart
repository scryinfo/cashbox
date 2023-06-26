//
//  Generated code. Do not modify.
//  source: cashbox_version_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use cashboxVersionOpenDescriptor instead')
const CashboxVersionOpen$json = {
  '1': 'CashboxVersionOpen',
  '3': [CashboxVersionOpen_UpgradeRes$json],
};

@$core.Deprecated('Use cashboxVersionOpenDescriptor instead')
const CashboxVersionOpen_UpgradeRes$json = {
  '1': 'UpgradeRes',
  '2': [
    {'1': 'err', '3': 1, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
    {'1': 'upgradeStatus', '3': 2, '4': 1, '5': 9, '10': 'upgradeStatus'},
    {'1': 'upgradeVersion', '3': 3, '4': 1, '5': 9, '10': 'upgradeVersion'},
  ],
};

/// Descriptor for `CashboxVersionOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cashboxVersionOpenDescriptor = $convert.base64Decode(
    'ChJDYXNoYm94VmVyc2lvbk9wZW4aewoKVXBncmFkZVJlcxIfCgNlcnIYASABKAsyDS5ycGNfZm'
    'FjZS5FcnJSA2VychIkCg11cGdyYWRlU3RhdHVzGAIgASgJUg11cGdyYWRlU3RhdHVzEiYKDnVw'
    'Z3JhZGVWZXJzaW9uGAMgASgJUg51cGdyYWRlVmVyc2lvbg==');

