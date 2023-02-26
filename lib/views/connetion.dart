// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:socket_io/socket_io.dart';

class ConnectionServer extends StatefulWidget {
  const ConnectionServer({super.key});
  @override
  State<ConnectionServer> createState() => _ConnectionServerState();
}

class _ConnectionServerState extends State<ConnectionServer> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 300,
        title: Text("Slide Ruler"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Servidor conectalo plis"),
            // OutlinedButton(onPressed: _conexion, child: const Text("conectar"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/* void _conexion() {
  final server = Server();
  print("hola");
  server.on('connection', (client) {
    print('$client esta conectado');

    client.on('stream', (data) {
      print('datos del clietne $data');
    });

    Timer(Duration(seconds: 5), () {
      client.emit('msg', 'hola al servidor');
    });
  });
  server.listen(1782);
  print("1782");
}
 */