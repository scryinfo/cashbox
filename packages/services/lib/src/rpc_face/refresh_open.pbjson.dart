//
//  Generated code. Do not modify.
//  source: refresh_open.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use refreshOpenDescriptor instead')
const RefreshOpen$json = {
  '1': 'RefreshOpen',
  '3': [RefreshOpen_ConnectParameterRes$json],
};

@$core.Deprecated('Use refreshOpenDescriptor instead')
const RefreshOpen_ConnectParameterRes$json = {
  '1': 'ConnectParameterRes',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'updateTime', '3': 2, '4': 1, '5': 3, '10': 'updateTime'},
    {'1': 'createTime', '3': 3, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'optimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'optimisticLockVersion'},
    {'1': 'host', '3': 5, '4': 1, '5': 9, '10': 'host'},
    {'1': 'port', '3': 6, '4': 1, '5': 3, '10': 'port'},
    {'1': 'cAPem', '3': 7, '4': 1, '5': 9, '10': 'cAPem'},
    {'1': 'servicePem', '3': 8, '4': 1, '5': 9, '10': 'servicePem'},
    {'1': 'cashboxKey', '3': 9, '4': 1, '5': 9, '10': 'cashboxKey'},
    {'1': 'cashboxPem', '3': 10, '4': 1, '5': 9, '10': 'cashboxPem'},
    {'1': 'remark', '3': 11, '4': 1, '5': 9, '10': 'remark'},
    {'1': 'err', '3': 12, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `RefreshOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshOpenDescriptor = $convert.base64Decode(
    'CgtSZWZyZXNoT3BlbhryAgoTQ29ubmVjdFBhcmFtZXRlclJlcxIOCgJpZBgBIAEoCVICaWQSHg'
    'oKdXBkYXRlVGltZRgCIAEoA1IKdXBkYXRlVGltZRIeCgpjcmVhdGVUaW1lGAMgASgDUgpjcmVh'
    'dGVUaW1lEjQKFW9wdGltaXN0aWNMb2NrVmVyc2lvbhgEIAEoA1IVb3B0aW1pc3RpY0xvY2tWZX'
    'JzaW9uEhIKBGhvc3QYBSABKAlSBGhvc3QSEgoEcG9ydBgGIAEoA1IEcG9ydBIUCgVjQVBlbRgH'
    'IAEoCVIFY0FQZW0SHgoKc2VydmljZVBlbRgIIAEoCVIKc2VydmljZVBlbRIeCgpjYXNoYm94S2'
    'V5GAkgASgJUgpjYXNoYm94S2V5Eh4KCmNhc2hib3hQZW0YCiABKAlSCmNhc2hib3hQZW0SFgoG'
    'cmVtYXJrGAsgASgJUgZyZW1hcmsSHwoDZXJyGAwgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');

