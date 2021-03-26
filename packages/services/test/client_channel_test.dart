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
  group('ClientTransportChannel', () {
    var server1;
    var server2;
    Server? serverRefresh;
    var refresh = RefreshOpen.get(new ConnectParameter("localhost", serverRefreshPort),
        "", AppPlatformType.any, "", "", "");
    bool odd = true;
    var channel = createClientChannel(() async {
      ConnectParameter re;
      if (odd) {
        odd = false;
        refresh.version = "1";
        re = (await refresh.refreshCall())!;
      } else {
        odd = true;
        refresh.version = "";
        re = (await refresh.refreshCall())!;
      }
      return re;
    }) as ClientTransportChannel;
    // channel = createClientChannel(refresh.refreshCall);
    final greeter = GreeterClient(channel);
    final name = 'scry';
    final message1 = 'port: $server1Port -- Hello $name!';
    final message2 = 'port: $server2Port -- Hello $name!';
    var killServer1 = () {
      _kill(server1);
      server1 = null;
    };
    var killServer2 = () {
      _kill(server2);
      server2 = null;
    };

    var callOkServer1 = () async {
      print("call sayHello");
      var response = await greeter.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      expect(message1, response.message);
      expect(server1Port, channel.connectParameter!.port);
    };

    var callOkServer2 = () async {
      print("call sayHello");
      var response = await greeter.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      expect(message2, response.message);
      expect(server2Port, channel.connectParameter!.port);
    };

    var callException = () async {
      await expectLater(() async {
        print("call sayHello");
        await greeter.sayHello(HelloRequest()..name = name);
      }(), throwsException);
      expect(
          null, channel.connectParameter); //由于调用失败所以，connectParameter is null
    };

    setUp(() async {
      odd = true;
      serverRefresh = await runRefreshServer(serverRefreshPort);
      // server1 = await Isolate.spawn( runServer,server1Port);
      // server2 = await Isolate.spawn( runServer,server2Port);
      // server1 = await runServer(server1Port);
      // server2 = await runServer(server2Port);
      // await Future.delayed(Duration(seconds: 1));
    });

    tearDown(() async {
      if (serverRefresh != null) {
        serverRefresh!.shutdown();
        serverRefresh = null;
      }
      killServer1();
      killServer2();
    });

    test('started all', () async {
      server1 = await runServer(server1Port);
      server2 = await runServer(server2Port);
      await Future.delayed(Duration(seconds: 1)); //确保server启动完成
      await callOkServer1();
      //再次调用，由上次是成功的，所以依然是server1
      await callOkServer1();

      killServer1(); //关闭 server1
      //上次是server1调用成功，所以依然使用server1，此时server1已经被关闭，所以出异常
      await callException();
      //再次调用，refresh起作用，所以这server2
      await callOkServer2();

      killServer2(); //关闭 server2
      //上次是server2调用成功，所以依然使用server2，此时server2已经被关闭，所以出异常
      await callException();
      //没有可用的server,多次调用也会失败
      await callException();
    });

    test('started server1', () async {
      server1 = await runServer(server1Port);
      // server2 = await runServer(server2Port);
      await Future.delayed(Duration(seconds: 1)); //确保server启动完成

      await callOkServer1();

      killServer1(); //关闭 server1
      //上次是server1调用成功，所以依然使用server1，此时server1已经被关闭，所以出异常
      await callException();
      //再次调用，refresh到server2，server2没有启动，调用失败
      await callException();
      //没有可用的server,多次调用也会失败
      await callException();
    });

    test('started server2', () async {
      // server1 = await runServer(server1Port);
      server2 = await runServer(server2Port);
      await Future.delayed(Duration(seconds: 1)); //确保server启动完成

      //server1没有启动，所以调用失败
      await callException();
      //再次调用，refresh到server2，同时server2是启动的，所以调用成功
      await callOkServer2();

      killServer1(); //关闭 server1
      //上次是server2调用成功，所以依然使用server2
      await callOkServer2();

      killServer2(); //关闭 server2
      //上次是server2调用成功，所以依然使用server2,但是server2关闭，所以异常
      await callException();
      //没有可用的server,多次调用也会失败
      await callException();
    });

    test('started 0', () async {
      await Future.delayed(Duration(seconds: 1)); //确保server启动完成

      //没有可用的server,会失败
      await callException();

      server1 = await runServer(server1Port); //启动server1
      //由于上次调用失败，refresh到server2，但server2没有启动，所以异常
      await callException();

      server2 = await runServer(server2Port); //启动server2
      //由于上次调用失败，refresh到server1，但server1已经启动，所以正常
      await callOkServer1();
      //由于上次调用成功，依然使用server1，所以正常
      await callOkServer1();
    });
  });
}
