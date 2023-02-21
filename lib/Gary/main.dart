import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io/socket_io.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Servidor"),
            OutlinedButton(onPressed: _conexion, child: const Text("conectar"))
          ],
        ),
      ),
    );
  }

  void _conexion() {
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
}
