import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:websocket/sockets/socketUtil.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  String _status;
  SocketUtil _socketUtil;
  List<String> _messages;

  @override
  void initState() {
    super.initState();

    _status = '';
    _socketUtil = new SocketUtil();
    _messages = List<String>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('$_status'),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return Text(_messages[index]);
              }, itemCount: _messages.length,),
            )
            // StreamBuilder(
            //   stream: widget.channel.stream,
            //   builder: (context, snapshot) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 24.0),
            //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //     );
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _socketUtil.sendMessage(
              _controller.text, connectionListener, messsageListener);
        }, //_sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // void _sendMessage()
  //   if (_controller.text.isNotEmpty) {
  //     widget.channel.sink.add(_controller.text);
  //   }
  // }

  void messsageListener(String message) {
    setState(() {
      _messages.add(message);
    });
    print(_messages);
  }

  void connectionListener(bool connected) {
    setState(() {
      _status = 'Status: ' + (connected ? 'Connected' : 'Failed to connect');
    });
  }

  @override
  void dispose() {
    // widget.channel.sink.close();
    super.dispose();
  }
}
