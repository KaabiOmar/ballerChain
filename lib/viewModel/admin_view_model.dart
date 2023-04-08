import 'dart:convert';

import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/user.dart';
import 'package:http/http.dart' as http;


class AdminViewModel {


  Future<String> deleteUser(String userId) async {
    final url = Uri.parse('$base_url/user/delete/$userId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
       print("user deleted successfully");
       return userId ;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
