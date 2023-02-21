import 'dart:async';

import 'package:socket_io/socket_io.dart';

main() {
  // Dart server
  var io = Server();
  io.on('connection', (client) {
    print('Cliente conectado');
    client.on('msg', (data) {
      print('data de cliente $data');
    });

    Timer(Duration(seconds: 5), () {
      client.emit('stream', 'hello');
    });
  });
  io.listen(3000);
}
