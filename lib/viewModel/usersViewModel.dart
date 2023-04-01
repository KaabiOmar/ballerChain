import 'dart:convert';

import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/user.dart';
import 'package:http/http.dart' as http;


class UsersViewModel {
  final url = Uri.parse('$base_url/user');

  Future<List<User>> getAllUser() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<User> users = data.map((user) => User.fromJson(user)).toList();
        return users;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
