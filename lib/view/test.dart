import 'package:ballerchain/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:logging/logging.dart';
import '../utils/shared_preference.dart';


class ChatScreen2 extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen2> {
  late IO.Socket socket;
  final logger = Logger('socket');
  String? userId;
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initUserId();
  }

  Future<void> initUserId() async {
    final id = await SharedPreference.getUserId();
    setState(() {
      userId = id;
    });
    connectToSocket();
  }

  void connectToSocket() {
    if (userId == null) {
      print('userId is not initialized yet, cannot connect');
      return;
    }

    try {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
      socket = IO.io('$url_ws', <String, dynamic>{
        'transports': ['websocket'],
      });
      socket.connect();
      socket.onConnect((_) {
        logger.info('Connected to socket!');
        socket.emit('register', userId);
      });

      socket.on('receive_message', (data) {
        print('Received message: $data');
        // Handle received message here
      });

      socket.onDisconnect((_) {
        print('Disconnected from socket!');
      });

      socket.on('error', (data) {
        print('Error: $data');
        // Handle error here
      });
    } catch (error) {
      print('Error while connecting to socket: $error');
    }
  }

  void sendMessage(String message) {
    socket.emit('send_message', {'user_id': userId, 'message': message});
  }

  void disconnectFromSocket() {
    socket.disconnect();
    logger.info('Disconnected from socket!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          TextButton(
            onPressed: () => disconnectFromSocket(),
            child: Text('Disconnect', style: TextStyle(color: Colors.white)),
          ),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Chat screen'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  final message = messageController.text;
                  if (message.isNotEmpty) {
                    sendMessage(message);
                    messageController.clear();
                  }
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
