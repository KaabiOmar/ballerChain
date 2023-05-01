import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/chat.dart';


class ChatViewModel {
  StreamController<List<Chat>> _chatListController =
  StreamController<List<Chat>>.broadcast();

  Stream<List<Chat>> get chatListStream => _chatListController.stream;

  Future<List<Chat>> getAllChats() async {
    final url = Uri.parse('$base_url/chat');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Chat> chats = data.map((chat) => Chat.fromJson(chat)).toList();
        _chatListController.add(chats);
        return chats;
      } else {
        throw Exception('Failed to get chats');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendMessage(String message, String user_id) async {
    final url = Uri.parse('$base_url/chat/user/$user_id');
    try {
      final response = await http.post(url, body: {
        'message': message,
        'senderId': user_id,
      });

      if (response.statusCode != 201) {
        throw Exception('Failed to send message');
      }
    } catch (error) {
      throw error;
    }
  }

  void dispose() {
    _chatListController.close();
  }
}
