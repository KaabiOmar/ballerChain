import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/viewModel/login_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class ProfileViewModel{


  Future<User> fetchUserById(String userId) async {
    final url = Uri.parse('$base_url/user/$userId');
    final response = await http.get(url);
    //print('$userId');

    if (response.statusCode == 200) {
      //print(response.body);
      final profileJson = jsonDecode(response.body) as Map<String, dynamic>;

      final user=User.fromJson(profileJson);

      print('je suis lid cherché ');

      if (kDebugMode) {
        print("profil:${user.email}");
        //print(user.firstname.toString());
      }
      return user;

    } else {
      throw Exception('Failed to load profile');
    }
  }
}
