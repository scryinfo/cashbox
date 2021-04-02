import 'package:client_dart/src/generated/greeter.pb.dart';
import 'package:client_dart/src/generated/greeter.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _replay = "";

  // late Client client;

  void _incrementCounter() async {
    // try {
    //   var replay = await client.greeter.sayHello(HelloRequest()
    //     ..name = "dart");
    //   setState(() {
    //     _counter++;
    //     _replay = replay.message;
    //   });
    // }catch(e){
    //   setState(() {
    //     _counter++;
    //     _replay = e.toString();
    //   });
    // }

    // clickDone = client.greeter.sayHello(HelloRequest()..name = "dart")
    //     .then((replay) => {
    //       setState(() {
    //         _counter++;
    //         _replay = replay.message;
    //       })
    //     });
    // await clickDone!;
    // var t = 0;

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
      var response =
          await Future.sync(() => stub.sayHello(HelloRequest()..name = name));
      print('Greeter client received: ${response.message}');
    } catch (e) {
      print('Caught error: $e');
    }
    channel.shutdown();
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
              '$_counter: $_replay',
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

  @override
  void initState() {
    // client = new Client();
    // client.init();
  }

  @override
  void dispose() {
    // client.uninit();
  }
}
