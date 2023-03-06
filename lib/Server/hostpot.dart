import 'dart:ffi' as ffi;
import 'dart:io';

typedef WlanOpenHandleC = ffi.Int32 Function(
    ffi.Uint32, ffi.Pointer<ffi.Void>, ffi.Uint32, ffi.Pointer<ffi.Void>);
typedef WlanOpenHandleDart = int Function(
    int, ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Void>);

typedef WlanCloseHandleC = ffi.Int32 Function(ffi.Pointer<ffi.Void>);
typedef WlanCloseHandleDart = int Function(ffi.Pointer<ffi.Void>);

typedef WlanHostedNetworkStartUsingC = ffi.Int32 Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Uint32,
    ffi.Uint32,
    ffi.Pointer<ffi.Void>);
typedef WlanHostedNetworkStartUsingDart = int Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    int,
    int,
    ffi.Pointer<ffi.Void>);

void main() {
  // Load the necessary Windows API DLL
  var wlanapi = ffi.DynamicLibrary.open('wlanapi.dll');

  // Get the function pointers for the WLAN API functions
  var wlanOpenHandle = wlanapi
      .lookupFunction<WlanOpenHandleC, WlanOpenHandleDart>('WlanOpenHandle');
  var wlanCloseHandle = wlanapi
      .lookupFunction<WlanCloseHandleC, WlanCloseHandleDart>('WlanCloseHandle');
  var wlanHostedNetworkStartUsing = wlanapi.lookupFunction<
      WlanHostedNetworkStartUsingC,
      WlanHostedNetworkStartUsingDart>('WlanHostedNetworkStartUsing');

// Open a handle to the WLAN API
  var handlePtr = ffi.Pointer<ffi.Void>.allocate();
  var negotiatedVersion = ffi.Pointer<ffi.Uint32>.allocate();
  var result = wlanOpenHandle(2, 0, negotiatedVersion, handlePtr.cast());
  if (result != 0) {
    print('Error opening handle to WLAN API');
    return;
  }
  var handle = handlePtr.cast<ffi.Pointer<ffi.Void>>().value;

// Start the hosted network
  var ssid = 'MyHotspot'; // replace with your preferred SSID
  var key = 'MyPassword'; // replace with your preferred password
  var hostnetPtr = ffi.Pointer<ffi.Void>.allocate();
  var reasonPtr = ffi.Pointer<ffi.Uint32>.allocate();
  result = wlanHostedNetworkStartUsing(
      handle, hostnetPtr.cast(), ffi.nullptr, 1, 1, reasonPtr.cast());
  if (result != 0) {
    print('Error starting hosted network');
    wlanCloseHandle(handle);
    return;
  }

/* // Open a handle to the WLAN API
var handlePtr = ffi.Pointer<ffi.Pointer<ffi.Void>>.fromAddress(0);
var negotiatedVersion = ffi.Pointer<ffi.Uint32>.fromAddress(0);
var result = wlanOpenHandle(2, ffi.nullptr, negotiatedVersion, handlePtr);
if (result != 0) {
  print('Error opening handle to WLAN API');
  return;
}
var handle = handlePtr.value;

// Start the hosted network
var ssid = 'MyHotspot'; // replace with your preferred SSID
var key = 'MyPassword'; // replace with your preferred password
var hostnetPtr = ffi.Pointer<ffi.Pointer<ffi.Void>>.fromAddress(0);
var reasonPtr = ffi.Pointer<ffi.Uint32>.fromAddress(0);
result = wlanHostedNetworkStartUsing(
    handle, hostnetPtr, ffi.nullptr, 1, 1, ffi.nullptr);
if (result != 0) {
  print('Error starting hosted network');
  wlanCloseHandle(handle);
  return;
}
 */
  // Close the handle to the WLAN API
  wlanCloseHandle(handle);
}


/* import 'dart:ffi' as ffi;
import 'dart:io';
typedef WlanOpenHandleC = ffi.Int32 Function(
    ffi.Uint32, ffi.Pointer<ffi.Void>, ffi.Uint32, ffi.Pointer<ffi.Void>);
typedef WlanOpenHandleDart = int Function(
    int, ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Void>);

typedef WlanCloseHandleC = ffi.Int32 Function(ffi.Pointer<ffi.Void>);
typedef WlanCloseHandleDart = int Function(ffi.Pointer<ffi.Void>);

typedef WlanHostedNetworkStartUsingC = ffi.Int32 Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Uint32,
    ffi.Uint32,
    ffi.Pointer<ffi.Void>);
typedef WlanHostedNetworkStartUsingDart = int Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    int,
    int,
    ffi.Pointer<ffi.Void>);

void main() {
  // Load the necessary Windows API DLL
  var wlanapi = ffi.DynamicLibrary.open('wlanapi.dll');

  // Get the function pointers for the WLAN API functions
  var wlanOpenHandle =
      wlanapi.lookupFunction<WlanOpenHandleC, WlanOpenHandleDart>('WlanOpenHandle');
  var wlanCloseHandle =
      wlanapi.lookupFunction<WlanCloseHandleC, WlanCloseHandleDart>('WlanCloseHandle');
  var wlanHostedNetworkStartUsing =
      wlanapi.lookupFunction<WlanHostedNetworkStartUsingC, WlanHostedNetworkStartUsingDart>(
          'WlanHostedNetworkStartUsing');

  // Open a handle to the WLAN API
  var handlePtr = ffi.Pointer<ffi.Void>.fromAddress(ptr)
  var negotiatedVersion = ffi.Allocator().allocate<ffi.Uint32>();
  var result = wlanOpenHandle(2, ffi.nullptr, negotiatedVersion, handlePtr);
  if (result != 0) {
    print('Error opening handle to WLAN API');
    return;
  }
  var handle = handlePtr.value;

  // Start the hosted network
  var ssid = 'MyHotspot'; // replace with your preferred SSID
  var key = 'MyPassword'; // replace with your preferred password
  var hostnetPtr = ffi.Allocator().allocate<ffi.Pointer<ffi.Void>>();
  var reasonPtr = ffi.Allocator().allocate<ffi.Uint32>();
  result = wlanHostedNetworkStartUsing(
      handle, hostnetPtr, ffi.nullptr, 1, 1, ffi.nullptr);
  if (result != 0) {
    print('Error starting hosted network');
    wlanCloseHandle(handle);
    return;
  }

  // Close the handle to the WLAN API
  wlanCloseHandle(handle);
}



/* import 'dart:ffi' as ffi;
import 'dart:io';
typedef WlanOpenHandleC = ffi.Int32 Function(
    ffi.Uint32, ffi.Pointer<ffi.Void>, ffi.Uint32, ffi.Pointer<ffi.Void>);
typedef WlanOpenHandleDart = int Function(
    int, ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Void>);

typedef WlanCloseHandleC = ffi.Int32 Function(ffi.Pointer<ffi.Void>);
typedef WlanCloseHandleDart = int Function(ffi.Pointer<ffi.Void>);

typedef WlanHostedNetworkStartUsingC = ffi.Int32 Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Uint32,
    ffi.Uint32,
    ffi.Pointer<ffi.Void>);
typedef WlanHostedNetworkStartUsingDart = int Function(
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    ffi.Pointer<ffi.Void>,
    int,
    int,
    ffi.Pointer<ffi.Void>);

void main() {
  // Load the necessary Windows API DLL
  var wlanapi = ffi.DynamicLibrary.open('wlanapi.dll');

  // Get the function pointers for the WLAN API functions
  var wlanOpenHandle =
      wlanapi.lookupFunction<WlanOpenHandleC, WlanOpenHandleDart>('WlanOpenHandle');
  var wlanCloseHandle =
      wlanapi.lookupFunction<WlanCloseHandleC, WlanCloseHandleDart>('WlanCloseHandle');
  var wlanHostedNetworkStartUsing =
      wlanapi.lookupFunction<WlanHostedNetworkStartUsingC, WlanHostedNetworkStartUsingDart>(
          'WlanHostedNetworkStartUsing');

  // Open a handle to the WLAN API
  var nose = ffi.Allocator
  var handlePtr = ffi.allocate<ffi.Pointer<ffi.Void>>();
  var negotiatedVersion = ffi.allocate<ffi.Uint32>();
  var result = wlanOpenHandle(2, ffi.nullptr, negotiatedVersion, handlePtr);
  if (result != 0) {
    print('Error opening handle to WLAN API');
    return;
  }
  var handle = handlePtr.value;

  // Start the hosted network
  var ssid = 'MyHotspot'; // replace with your preferred SSID
  var key = 'MyPassword'; // replace with your preferred password
  var hostnetPtr = ffi.allocate<ffi.Pointer<ffi.Void>>();
  var reasonPtr = ffi.allocate<ffi.Uint32>();
  result = wlanHostedNetworkStartUsing(
      handle, hostnetPtr, ffi.nullptr, 1, 1, ffi.nullptr);
  if (result != 0) {
    print('Error starting hosted network');
    wlanCloseHandle(handle);
    return;
  }

  // Close the handle to the WLAN API
  wlanCloseHandle(handle);
}

 */


/* import 'dart:ffi';

import 'package:win32/win32.dart';

void main() {
  // Obtener un identificador para el objeto de WLAN
  final hClient = allocate<IntPtr>();
  WlanOpenHandle(2, nullptr, hClient);

  // Obtener un identificador para la interfaz WLAN
  final dwMaxClient = 2; // número máximo de clientes que pueden conectarse
  final ppInterfaceList = allocate<Pointer<PPWLAN_INTERFACE_INFO_LIST>>();
  WlanEnumInterfaces(hClient.value, nullptr, ppInterfaceList);
  final pInterfaceList = ppInterfaceList.value.ref;
  final pInterfaceInfo = pInterfaceList.InterfaceInfo.cast<WLAN_INTERFACE_INFO>();

  // Configurar el punto de acceso inalámbrico
  final ssid = 'MyHotspotSSID';
  final key = 'MyHotspotKey';
  final wlanHostedNetworkParams = allocate<WLAN_HOSTED_NETWORK_PARAMETERS>()
    ..hostedNetworkSSID = ssid.toNativeUtf16()
    ..dwMaxNumberOfPeers = 100
    ..hostedNetworkMode = WLAN_HOSTED_NETWORK_OPCODE_ENABLE
    ..dot11PhyType = DOT11_PHY_TYPE_DOT11_PHY_TYPE_ANY;

  WlanHostedNetworkSetProperty(
    hClient.value,
    WLAN_HOSTED_NETWORK_OPCODE_HOSTED_NETWORK_SECURITY_SETTINGS,
    key.length + 1, // longitud de la cadena de clave de seguridad
    key.toNativeUtf16(),
    nullptr,
  );

  // Iniciar el punto de acceso inalámbrico
  WlanHostedNetworkInitSettings(hClient.value, wlanHostedNetworkParams, nullptr);
  WlanHostedNetworkStartUsing(hClient.value, nullptr);

  // Liberar recursos
  free(wlanHostedNetworkParams.hostedNetworkSSID);
  WlanCloseHandle(hClient.value, nullptr);
} */ */