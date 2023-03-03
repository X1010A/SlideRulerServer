import 'dart:io';

void main() {
  var interfaces = NetworkInterface.list();
  List<String> net = [];
  interfaces.then((list) {
    list.forEach((interface) {
      interface.addresses.forEach((direciones) {
        if (direciones.type == InternetAddressType.IPv4) {
          print('${interface.name}: ${direciones.address}');
          net.add('${interface.name}: ${direciones.address}');
        }
      });
    });
  });
}
