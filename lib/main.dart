import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'WebSocket Example',
      home: WebSocketScreen(),
    );
  }
}

class WebSocketScreen extends StatefulWidget {
  const WebSocketScreen({super.key});

  @override
  _WebSocketScreenState createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  late WebSocketChannel? channel;
  final Map<String, dynamic>? headers = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> _connectWebSocket() async {
    const socketUrl = 'ws://smartapisocket.angelone.in/smart-stream';
    channel = IOWebSocketChannel.connect(socketUrl, headers: headers);

    // Listen for incoming WebSocket data.
    channel?.stream.listen((data) {
      // Handle the received data here.
      print('Received: $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<void>(
              future: _connectWebSocket(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Text('WebSocket Data:');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }
}
