import 'dart:io';

void main() async {
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
