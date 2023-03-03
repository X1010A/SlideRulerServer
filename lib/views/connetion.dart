import 'dart:io';
import 'package:flutter/material.dart';

class ConnectionServer extends StatefulWidget {
  const ConnectionServer({super.key});

  @override
  State<ConnectionServer> createState() => _ConnectionServerState();
}

class _ConnectionServerState extends State<ConnectionServer> {
  List<String> names = ['gary', 'juan', 'roberto'];
  List<String> net = [];
  List<String> direct = [];
  @override
  void initState() {
    super.initState();
    ips();
  }

  void ips() {
    var interfaces = NetworkInterface.list();
    interfaces.then((list) {
      list.forEach((interface) {
        interface.addresses.forEach((direciones) {
          if (direciones.type == InternetAddressType.IPv4) {
            setState(() {
              net.add('${interface.name}: ${direciones.address}');
              direct.add(direciones.address);
              print(direct);
            });
          }
        });
      });
    });
  }

  void conexion() async {
    final server = await ServerSocket.bind('192.168.1.3', 1782);
    print('Servidor escuchando en ${server.address}:${server.port}');

    server.listen((client) {
      print(
          'Cliente conectado desde ${client.remoteAddress}:${client.remotePort}');

      client.write('Hola, cliente');
      client.listen((data) {
        print('Mensaje recibido del cliente: ${String.fromCharCodes(data)}');
      }, onDone: () {
        print('Cliente desconectado');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Slide Ruler"),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: const Text('Iniar Servidor'),
                  onPressed: () {
                    print('hooa');
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Estado del servidor'),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Entradas'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: ListView.builder(
                    itemCount: net.length,
                    itemBuilder: (context, index) {
                      final name = net[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(name),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
