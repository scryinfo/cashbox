import 'dart:async';
import 'dart:isolate';

import 'package:client_dart/src/generated/greeter.pb.dart';
import 'package:client_dart/src/generated/greeter.pbgrpc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late MyHomePage home;

  @override
  Widget build(BuildContext context) {
    home = MyHomePage(title: 'Flutter Demo Home Page');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: home,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  Completer<bool>? callGrpc;
  MyHomePageState state = MyHomePageState();

  @override
  MyHomePageState createState() => state;
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  String replay = "";

  // late Client client;
  void _incrementCounter() async {
    widget.callGrpc = Completer.sync();
    // final channel = ClientChannel(
    //   '192.168.2.5',
    //   port: 50061,
    //   options: const ChannelOptions(
    //       credentials: ChannelCredentials.insecure(),
    //       connectionTimeout: Duration(minutes: 1)),
    // );
    // final stub = GreeterClient(channel);
    // String message = '';
    // try {
    //   var replay = await stub.sayHello(HelloRequest()..name = "dart");
    //   message = replay.message;
    // } catch (e) {
    //   print(e);
    // } finally {
    //   channel.shutdown();
    // }
    // setState(() {
    //   counter++;
    //   replay = message;
    //   if (message.isNotEmpty) {
    //     widget.callGrpc!.complete(true);
    //   } else {
    //     widget.callGrpc!.complete(false);
    //   }
    // });

    //在单元测试的情况下，如果界面的事件函数有调用grpc时，程序会卡死，这里把它放入isolate中可以运行
    var rPort1 = new ReceivePort();
    var isolate = await Isolate.spawn(funCompute, rPort1.sendPort);
    var sub = rPort1.listen(null);
    sub.onData((message) async {
      try {
        await sub.cancel();
        rPort1.close();
        isolate.kill();
      } catch (e) {
        print(e);
      }
      setState(() {
        counter++;
        replay = message;
        if (message.isNotEmpty) {
          widget.callGrpc!.complete(true);
        } else {
          widget.callGrpc!.complete(false);
        }
      });
    });
  }

  static funCompute(SendPort it) async {
    // return;
    final channel = ClientChannel(
      '192.168.2.5',
      port: 50061,
      options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectionTimeout: Duration(minutes: 1)),
    );
    final stub = GreeterClient(channel);
    final name = 'world';
    try {
      var response = await stub.sayHello(HelloRequest()..name = name);
      print('Greeter client received: ${response.message}');
      it.send(response.message);
    } catch (e) {
      print('Caught error: $e');
      it.send("");
    } finally {
      channel.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter: $replay',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
