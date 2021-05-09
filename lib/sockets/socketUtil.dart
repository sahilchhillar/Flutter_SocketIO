import 'dart:convert';
import 'dart:io';

class SocketUtil {
  Socket _socket;
  static const String SERVER_IP = "127.0.0.1";
  static const int SERVER_PORT = 6000;

  Future<bool> sendMessage(String message, Function connectionListener,
      Function messageListener) async {
    print("Hello");
    try {
      print("Got it");
      _socket = await Socket.connect(SERVER_IP, SERVER_PORT);
      connectionListener(true);
      _socket.listen((List<int> event) {
        String message = utf8.decode(event);
        print("Message: $message");
        messageListener(message);
      });

      //Send message to server
      _socket.add(utf8.encode(message));
      _socket.close();

      return true;
    } catch (e) {
      print("Some thing is wrong: " + e.toString());
      connectionListener(false);
      return false;
    }
  }

  void cleanUp() {
    if (null != _socket) {
      _socket.destroy();
    }
  }
}
