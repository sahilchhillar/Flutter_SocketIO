import 'package:flutter/material.dart';
import 'package:websocket/sockets/socket.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
        //channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}