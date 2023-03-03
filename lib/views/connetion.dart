import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:core';

class ConnectionServer extends StatefulWidget {
  const ConnectionServer({super.key});

  @override
  State<ConnectionServer> createState() => _ConnectionServerState();
}

class _ConnectionServerState extends State<ConnectionServer> {
  List<String> net = [];
  List<String> direct = [];
  String? ip;
  late String status = "Apagado";
  String cliente = '';
  String inputCliente = '';
  Widget? _widget;

  late final server;
  final keyForm = GlobalKey<FormState>();
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
    setState(() {
      status = 'Iniciando..';
    });
    try {
      server = await ServerSocket.bind(ip, 1782);
      print('Servidor escuchando en ${server.address}:${server.port}');

      setState(() {
        status = 'Servidor escuchando en ${server.address}:${server.port}';
      });
      server.listen((client) {
        print(
            'Cliente conectado desde ${client.remoteAddress}:${client.remotePort}');
        setState(() {
          cliente =
              'Cliente conectado desde ${client.remoteAddress}:${client.remotePort}';
        });

        client.write('Hola, cliente');
        client.listen((data) {
          print('Mensaje recibido del cliente: ${String.fromCharCodes(data)}');
          setState(() {
            inputCliente =
                'Mensaje recibido del cliente: ${String.fromCharCodes(data)}';
          });
        }, onDone: () {
          print('Cliente desconectado');
          setState(() {
            inputCliente = 'Cliente desconectado';
          });
        });
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        status = 'Error al Iniciar:\n ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slide Ruler"),
      ),
      body: Form(
        key: keyForm,
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Direccion IP',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    setState(() {
                      ip = newValue;
                    });
                  },
                  validator: (value) {
                    // ignore: unnecessary_new
                    RegExp exp = new RegExp(
                        r"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");
                    var net = value!;
                    bool isValid = exp.hasMatch(net);
                    if (net.isEmpty) {
                      return "LLene esta linea";
                    } else if (!isValid) {
                      return "Ejemplo: Ethernet: 192.168.1.1";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    child: const Text('Iniar Servidor'),
                    onPressed: () {
                      _changeState();
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  if (_widget != null) _widget!,
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  status,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(cliente),
                    Text(inputCliente),
                  ],
                ),
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
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(name),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeState() {
    if (keyForm.currentState!.validate()) {
      keyForm.currentState?.save();
      print(ip);
      conexion();
      setState(() {
        _widget = TweenAnimationBuilder(
          tween: Tween(begin: 1.0, end: 0.0),
          duration: const Duration(seconds: 1),
          builder: (context, value, _) {
            return Opacity(
              opacity: 1 - value,
              child: Transform.translate(
                offset: Offset(value * 50, 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      setState(() {
                        server.close();
                      });
                      _widget = null;
                    });
                  },
                  child: const Text('Apagar'),
                ),
              ),
            );
          },
        );
      });
    }
  }
}
