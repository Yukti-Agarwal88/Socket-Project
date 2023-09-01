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

  @override
  void initState() {
    super.initState();
  }

  Future<void> _connectWebSocket() async {
    const socketUrl = 'ws://smartapisocket.angelone.in/smart-stream';
    channel = IOWebSocketChannel.connect(socketUrl, headers: {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImU4YTIzZjM5LWVjM2YtNDczNi1hMjExLTY0N2E3MTdiNjMzNSJ9.eyJtb2JpbGVOdW1iZXIiOiI5OTEwMTc4NDk9nikkiwidXNlclR5cGUiOiJDVVNUT01FUiIsInVzZXJJZCI6ImRiMGFmZGIwLTJmNmYtMTFlZS1hYmE9ikI5ZGQ5MTA2ZGJjNTQiLCJsb2dpblR5cGUiOiJNT0JJTEVfTlVNQkVSX09UUCIsInJvbGUiOiJjdXN0b21lciIsImRldmljZUlkIjoiZWRlYjQ1OTAtN2I4MS0xMWVkLWIyOWYtZGJhODdlYTEwYmZmIiwicGxhdGZvcm0iOiJBTiIsImtleWlkIjoiZThhMjNmMzktZWMzZi00NzM2LWEyMTEtNjQ3YTcxN2I2MzM1IiwianRpIjoiVGJwWno5ZTVjSCIsImlhdCI6MTY5MzU1NTMxMSwiZXhwIjoxNjkzOTc1MzExLCJhdWQiOlsiQ1VTVE9NRVIiXSwiaXNzIjoiZmluaW5maW5pdHkgdGVjaG5vbG9neSBwcml2YXRlIGxpbWl0ZWQiLCJzdWIiOiJkZXZlbG9wZXJAZWF6eWZpbi5jb20ifQ.MIP4V9nmiXHqIy1C0gia8NP5BaV59HOXQ5Zd_Ioh5kL--MmKkoheHxxfafgJYCgcAYYFILDugkDmKCw2tt-PtqW1SaiP6SOLrFrGYB2gQkkOh4F2vIhHED0fdCw3SxmQiWMivNuTI9cewitC_Jwox60qMpq73dJOEQUGEBBvHHY',
      'x-api-key': 'Nvfk4nJJ',
      'x-client-code': "h137892",
      'x-feed-token':
          "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IkgxMzc4OTIiLCJpYXQiOjE2OTM1NTUzOTcsImV4cCI6MTY5MzY0MTc5N30.bot3p41Z-cIktYvPwbeQDssD-W4X5Q7jVjDu1lvkklirX59_9F1xCdRHPov_SLhGRjS1uSlZtUvmagHADzqnkg",
    });

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
