import 'dart:io';

import 'package:grpc/grpc.dart';

class ChannelCredentialsEx extends ChannelCredentials {
  List<int> certBytes;
  List<int> keyBytes;
  List<int> chainBytes;

  ChannelCredentialsEx(this.certBytes, this.keyBytes, this.chainBytes,
      {BadCertificateHandler onBadCertificate})
      : super.secure(onBadCertificate: onBadCertificate);

  @override
  SecurityContext get securityContext {
    // SecurityContext context = new SecurityContext(withTrustedRoots: true);
    // context.setAlpnProtocols(supportedAlpnProtocols, false);
    //
    // // context.setTrustedCertificatesBytes(certBytes);
    // context.usePrivateKeyBytes(keyBytes);
    // context.useCertificateChainBytes(chainBytes);

    SecurityContext context = new SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(certBytes);
    return context;
  }
}
