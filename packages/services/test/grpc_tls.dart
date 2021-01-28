@Timeout(const Duration(minutes: 10))
import 'dart:async';
import 'dart:isolate';

import 'package:grpc/grpc.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_client/client_channel.dart';
import 'package:test/test.dart';

import 'greeter/greeter.pbgrpc.dart';
import 'greeter/refresh.dart';
import 'greeter/server.dart';

void _kill(dynamic s) async {
  if (s == null) {
    return;
  }
  try {
    if (s is Isolate) {
      s.kill();
    } else {
      await s.shutdown();
    }
  } catch (e) {
    print(e);
  }
}

void main() {
  group('ClientTransportChannel tls', () {
    var serverTls1;
    Server serverRefreshTls;
    var refresh = Refresh.get(new ConnectParameter("localhost",serverRefreshPort),"",AppPlatformType.any);
    bool odd = true;
    var channel = createClientChannel(refresh.refreshCall) as ClientTransportChannel;
    final greeter = GreeterClient(channel);
    final name = 'scry';
    final message1 = 'port: $server1Port -- Hello $name!';
    var killServer1 = () {
      _kill(serverTls1);
      serverTls1 = null;
    };

    var callOkServer1 = () async {
      print("call sayHello");
      var response = await greeter.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      expect(message1, response.message);
      expect(server1Port, channel.connectParameter.port);
    };

    var callException = () async {
      await expectLater(() async {
        print("call sayHello");
        await greeter.sayHello(HelloRequest()..name = name);
      }(), throwsException);
      expect(
          null, channel.connectParameter); //由于调用失败所以，connectParameter is null
    };

    tearDown(() async {
      if(serverRefreshTls != null){
        serverRefreshTls.shutdown();
        serverRefreshTls = null;
      }
      killServer1();
    });

    test('started all', () async {
      serverRefreshTls = await runRefreshServer(serverRefreshPort);
      serverTls1 = await runServer(server1Port);
      await Future.delayed(Duration(seconds: 1)); //确保server启动完成
      await callOkServer1();
      //再次调用，由上次是成功的，所以依然是server1
      await callOkServer1();

      killServer1(); //关闭 server1
      //上次是server1调用成功，所以依然使用server1，此时server1已经被关闭，所以出异常
      await callException();
      await callException();

      serverTls1 = await runServer(server1Port);
      await callOkServer1();
    });

  });
}
