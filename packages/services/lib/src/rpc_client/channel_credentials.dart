import 'dart:io';

import 'package:grpc/grpc.dart';

class ChannelCredentialsEx extends ChannelCredentials {
  List<int> certBytes;
  List<int> keyBytes;
  List<int> chainBytes;

  ChannelCredentialsEx(this.certBytes, this.keyBytes, this.chainBytes, {BadCertificateHandler? onBadCertificate})
      : super.secure(onBadCertificate: onBadCertificate);

  @override
  SecurityContext get securityContext {
    //dart不支持使用dot组件生成的证书及key,所以只能单向认证
    SecurityContext context = createSecurityContext(true);
    // context.setAlpnProtocols(supportedAlpnProtocols, false);

    // context.setTrustedCertificatesBytes(certBytes);
    // context.usePrivateKeyBytes(keyBytes);
    // context.useCertificateChainBytes(chainBytes);
    // context.setClientAuthoritiesBytes(certBytes);

    // SecurityContext context = new SecurityContext(withTrustedRoots: true);
    // context.setTrustedCertificatesBytes(certBytes);
    return context;
  }
}
