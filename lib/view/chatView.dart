import 'dart:async';

import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/viewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ballerchain/model/chat.dart';

import '../utils/shared_preference.dart';
import '../viewModel/chat_View_Model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ChatViewModel _viewModel = ChatViewModel();
  late String _userId;
  late StreamController<List<Chat>> _chatsController;
  late Stream<List<Chat>> _chatsStream;

  @override
  void initState() {
    super.initState();
    _chatsController = StreamController<List<Chat>>();
    _chatsStream = _chatsController.stream;
    _getChats();
    SharedPreference.getUserId().then((value) {
      setState(() {
        _userId = value!;
      });
    });
  }

  void _getChats() async {
    final chats = await _viewModel.getAllChats();
    _chatsController.add(chats);
  }

  void _sendMessage() async {
    final message = _textController.text.trim();
    String? userId;
    SharedPreference.getUserId().then((value) async {
      userId = value;
      if (message.isNotEmpty) {
        await _viewModel.sendMessage(message, userId!);
        _textController.clear();
        _getChats();

      }
    });
  }

  Widget _buildChatList() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ball.png'),
          fit: BoxFit.cover,
          opacity: 10,
        ),
      ),
      child: StreamBuilder(
        stream: _chatsStream,
        builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
          if (snapshot.hasData) {
            final chats = snapshot.data!;
            return ListView.builder(
              //reverse: true,
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final isMe = chat.user_id == _userId;
                return FutureBuilder(
                  future: ProfileViewModel().fetchUserById(chat.user_id!),
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.purple.shade400 : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.firstname!,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple.shade700),
                              ),
                              SizedBox(height: 8),
                              Text(
                                chat.message!,
                                textAlign: isMe ? TextAlign.right : TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BallerChat',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bgrnd.png'), // Chemin de l'image
              fit: BoxFit.none, // Mode de redimensionnement de l'image
            ),
          ),
        ),

      ),
      body: Column(
        children: [
          Expanded(child: _buildChatList()),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.purple,
                ),
                onPressed: _sendMessage,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Définir un padding personnalisé
              filled: true,
              fillColor: Colors.purple[100], // Modifier la couleur du fond
              border: OutlineInputBorder(
               // borderRadius: BorderRadius.circular(30), // Ajouter un border arrondi
                borderSide: BorderSide.none, // Supprimer les bordures
              ),
            ),
          ),

        ],
      ),
    );
  }
}
