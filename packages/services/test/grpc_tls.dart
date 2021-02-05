@Timeout(const Duration(minutes: 10))
import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:pem/pem.dart';
import 'package:services/services.dart';
import 'package:test/test.dart';

import 'greeter/greeter.pbgrpc.dart';
import 'greeter/server.dart';

void main() {
  test('ClientTransportChannel server tls', () async {
    Process serverTls1;
    var channel = createClientChannel(() async {
      ConnectParameter re = new ConnectParameter("localhost", 50051);
      re.options = ChannelOptions(
          credentials: ChannelCredentials.secure(
              onBadCertificate: (certificate, host) =>
                  certificate.subject.endsWith('scry') &&
                  host == '${re.host}:${re.port}'));
      return re;
    }) as ClientTransportChannel;
    final greeter = GreeterClient(channel);
    final name = 'scry';
    final message1 = 'replay $name';

    var callOkServer1 = () async {
      print("call sayHello");
      var response = await greeter.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      expect(message1, response.message);
    };

    var callException = () async {
      await expectLater(() async {
        print("call sayHello");
        await greeter.sayHello(HelloRequest()..name = name);
      }(), throwsException);
      expect(
          null, channel.connectParameter); //由于调用失败所以，connectParameter is null
    };
    var killServer1 = () {
      Process.killPid(serverTls1.pid);
      serverTls1 = null;
    };
    serverTls1 = await runGoServer();
    await Future.delayed(Duration(seconds: 1)); //确保server启动完成
    await callOkServer1();
    //再次调用，由上次是成功的，所以依然是server1
    await callOkServer1();

    killServer1(); //关闭 server1
    //上次是server1调用成功，所以依然使用server1，此时server1已经被关闭，所以出异常
    await callException();
    await callException();

    serverTls1 = await runGoServer();
    await callOkServer1();
    killServer1();
  });
  test('ClientTransportChannel Mutual tls', () async {
    //todo 不能成功连接服务端，所以直接返回
    // return;
    Process serverTls1;
    var channel = createClientChannel(() async {
      ConnectParameter re = new ConnectParameter("localhost", 50051);
      var ca = new File('test/greeter/greeter_go/greeter_go/ca.pem')
          .readAsStringSync();
      // var server = new File('test/greeter/greeter_go/greeter_go/server.pem').readAsStringSync();
      var pubKey = new File('test/greeter/client.pem').readAsStringSync();
      var privateKey = new File('test/greeter/client.key').readAsStringSync();
      List<int> certCa = PemCodec(PemLabel.certificate).decode(ca);
      List<int> certPubKey = PemCodec(PemLabel.certificate).decode(pubKey);
      List<int> certPrivateKey =
          PemCodec(PemLabel.privateKey).decode(privateKey);
      re.options = ChannelOptions(
          credentials: new ChannelCredentialsEx(
              certCa, certPrivateKey, certPubKey,
              onBadCertificate: (certificate, host) =>
                  certificate.subject.endsWith('scry') &&
                  host == '${re.host}:${re.port}'));
      return re;
    }) as ClientTransportChannel;
    final greeter = GreeterClient(channel);
    final name = 'scry';
    final message1 = 'replay $name';

    var callOkServer1 = () async {
      print("call sayHello");
      var response = await greeter.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      expect(message1, response.message);
    };
    var killServer1 = () {
      Process.killPid(serverTls1.pid);
      serverTls1 = null;
    };
    serverTls1 = await runGoServer();
    await Future.delayed(Duration(seconds: 1)); //确保server启动完成
    await callOkServer1();
    await callOkServer1();

    killServer1();
  });
}
