///
//  Generated code. Do not modify.
//  source: refresh_open.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use refreshOpenDescriptor instead')
const RefreshOpen$json = const {
  '1': 'RefreshOpen',
  '3': const [RefreshOpen_ConnectParameterRes$json],
};

@$core.Deprecated('Use refreshOpenDescriptor instead')
const RefreshOpen_ConnectParameterRes$json = const {
  '1': 'ConnectParameterRes',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'updateTime', '3': 2, '4': 1, '5': 3, '10': 'updateTime'},
    const {'1': 'createTime', '3': 3, '4': 1, '5': 3, '10': 'createTime'},
    const {'1': 'optimisticLockVersion', '3': 4, '4': 1, '5': 3, '10': 'optimisticLockVersion'},
    const {'1': 'host', '3': 5, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 6, '4': 1, '5': 3, '10': 'port'},
    const {'1': 'cAPem', '3': 7, '4': 1, '5': 9, '10': 'cAPem'},
    const {'1': 'servicePem', '3': 8, '4': 1, '5': 9, '10': 'servicePem'},
    const {'1': 'cashboxKey', '3': 9, '4': 1, '5': 9, '10': 'cashboxKey'},
    const {'1': 'cashboxPem', '3': 10, '4': 1, '5': 9, '10': 'cashboxPem'},
    const {'1': 'remark', '3': 11, '4': 1, '5': 9, '10': 'remark'},
    const {'1': 'err', '3': 12, '4': 1, '5': 11, '6': '.rpc_face.Err', '10': 'err'},
  ],
};

/// Descriptor for `RefreshOpen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshOpenDescriptor = $convert.base64Decode('CgtSZWZyZXNoT3BlbhryAgoTQ29ubmVjdFBhcmFtZXRlclJlcxIOCgJpZBgBIAEoCVICaWQSHgoKdXBkYXRlVGltZRgCIAEoA1IKdXBkYXRlVGltZRIeCgpjcmVhdGVUaW1lGAMgASgDUgpjcmVhdGVUaW1lEjQKFW9wdGltaXN0aWNMb2NrVmVyc2lvbhgEIAEoA1IVb3B0aW1pc3RpY0xvY2tWZXJzaW9uEhIKBGhvc3QYBSABKAlSBGhvc3QSEgoEcG9ydBgGIAEoA1IEcG9ydBIUCgVjQVBlbRgHIAEoCVIFY0FQZW0SHgoKc2VydmljZVBlbRgIIAEoCVIKc2VydmljZVBlbRIeCgpjYXNoYm94S2V5GAkgASgJUgpjYXNoYm94S2V5Eh4KCmNhc2hib3hQZW0YCiABKAlSCmNhc2hib3hQZW0SFgoGcmVtYXJrGAsgASgJUgZyZW1hcmsSHwoDZXJyGAwgASgLMg0ucnBjX2ZhY2UuRXJyUgNlcnI=');
