import 'dart:ffi';
import 'dart:io';

final DynamicLibrary user32 = Platform.isWindows
    ? DynamicLibrary.open('user32.dll')
    : DynamicLibrary.process();

final int Function(int, int) keybd_event = user32
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('keybd_event')
    .asFunction();

final int Function(int) XKeysymToKeycode = user32
    .lookup<NativeFunction<Int32 Function(Int32)>>('XKeysymToKeycode')
    .asFunction();

final void Function(Pointer) XFree =
    user32.lookup<NativeFunction<Void Function(Pointer)>>('XFree').asFunction();

class KeySimulator {
  static void simulate(int keyCode) {
    if (Platform.isWindows) {
      keybd_event(keyCode, 2);
      keybd_event(keyCode, 100);
    } else if (Platform.isLinux) {
      try {} catch (e) {
        print(
            "Aun no soportamos Linux, muy pronto tendremos nuevas actulizaciones para tu sistemas");
      }
      /*    final display = XOpenDisplay(nullptr);
      final keycode = XKeysymToKeycode(display, keyCode);
      final event = calloc.allocate<XEvent>(sizeOf<XKeyEvent>());
      event.ref.type = KeyPress;
      event.ref.xkey.display = display;
      event.ref.xkey.window = XDefaultRootWindow(display);
      event.ref.xkey.root = XDefaultRootWindow(display);
      event.ref.xkey.subwindow = None;
      event.ref.xkey.time = 0;
      event.ref.xkey.x = 1;
      event.ref.xkey.y = 1;
      event.ref.xkey.x_root = 1;
      event.ref.xkey.y_root = 1;
      event.ref.xkey.state = 0;
      event.ref.xkey.keycode = keycode;
      XSendEvent(
          display, XDefaultRootWindow(display), true, KeyPressMask, event);
      event.ref.type = KeyRelease;
      XSendEvent(
          display, XDefaultRootWindow(display), true, KeyReleaseMask, event);
      calloc.free(event);
      XFree(Pointer.fromAddress(display.address));  */
    }
  }
}

void main() async {
  // Presionar la tecla 'A' (código ASCII 65)
  await Future.delayed(Duration(seconds: 5));

  KeySimulator.simulate(39);
}



/* 

install xdotool
para linux
import 'dart:io';

void main() {
  // Ejecutar el comando xdotool para enviar la tecla "a"
  Process.run('xdotool', ['key', 'a']).then((ProcessResult result) {
    // Manejar el resultado de la ejecución del comando
    print(result.stdout);
    print(result.stderr);
  });



para windows 


import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

typedef KeybdEventC = Void Function(Uint8, Uint8, Uint32, IntPtr);
typedef KeybdEventDart = void Function(int, int, int, int);

final user32 = DynamicLibrary.open('user32.dll');

final keybd_event = user32.lookupFunction<KeybdEventC, KeybdEventDart>(
  'keybd_event',
);

void main() {
  // Simula la pulsación de la tecla "a"
  keybd_event(0x42, 0, KEYEVENTF_EXTENDEDKEY, 0);
  keybd_event(0x42, 0, KEYEVENTF_KEYUP, 0);
}
 */