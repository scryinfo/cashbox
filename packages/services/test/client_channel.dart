@Timeout(const Duration(minutes: 10))
import 'dart:isolate';

import 'package:services/services.dart';
import 'package:test/test.dart';

import 'greeter/greeter.pbgrpc.dart';
import 'greeter/server.dart';

void kill(dynamic s) async {
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
    setUp(() async {
      // server1 = await Isolate.spawn( runServer,server1Port);
      // server2 = await Isolate.spawn( runServer,server2Port);

      server1 = await runServer(server1Port);
      server2 = await runServer(server2Port);
      await Future.delayed(Duration(seconds: 1));
    });

    tearDown(() async {
      await kill(server1);
      server1 = null;
      await kill(server2);
      server2 = null;
    });

    test('ClientTransportChannel - ReFreshParameter', () async {
      await Future.delayed(Duration(seconds: 1));
      bool odd = true;
      final channel =
          createChannel(ConnectParameter("localhost", 5000), (p) async {
        ConnectParameter re;
        if (odd) {
          odd = false;
          re = ConnectParameter("localhost", server1Port);
        } else {
          odd = true;
          re = ConnectParameter("localhost", server2Port);
        }
        return re;
      });
      final stub = GreeterClient(channel);

      final name = 'world';

      //调用2次
      for (int i = 0; i < 2; i++) {
        try {
          print("call sayHello");
          final response = await stub.sayHello(HelloRequest()..name = name);
          print('Greeter client received: ${response.message}');
        } catch (e) {
          print('Caught error: $e');
        }
      }

      //关闭 server1
      kill(server1);
      server1 = null;
      {
        //调用失败，server1已关闭
        try {
          print("call sayHello");
          final response = await stub.sayHello(HelloRequest()..name = name);
          print('Greeter client received: ${response.message}');
        } catch (e) {
          print('Caught error: $e');
        }
      }

      {
        //再次调用，refresh起作用，所以这
        for (int i = 0; i < 2; i++) {
          try {
            print("call sayHello");
            final response = await stub.sayHello(HelloRequest()..name = name);
            print('Greeter client received: ${response.message}');
          } catch (e) {
            print('Caught error: $e');
          }
        }
      }
    });
  });
}
