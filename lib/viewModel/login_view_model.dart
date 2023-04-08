import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/const.dart';
import 'package:ballerchain/utils/shared_preference.dart';

import '../model/user.dart';



class LoginViewModel{
  String roleLogin="";

  Future<dynamic> login(BuildContext context, String email,String password) async {
    final preferences= await  SharedPreferences.getInstance();
    final url = Uri.parse('$base_url/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print("je suis la ");

    if (response.statusCode == 200) {
      // Login successful
      final jsonResponse = json.decode(response.body);
      final userJson = jsonResponse['user'] as Map<String, dynamic>;
      //Map<String,dynamic> userJson1 = jsonResponse['user'] ;

      final accessToken = jsonResponse['accessToken'] as String;
      final id = userJson['_id'] as String;
      SharedPreference.setToken(accessToken);
      SharedPreference.setUserId(id);

      final roleFromJson = userJson['role'] as String;
      roleLogin =roleFromJson;


      print('Access Token: $accessToken');
      print('voici id: $id');
      print('id stocke dans sharedpreference: ${await SharedPreference.getUserId()}');
      //print(response.body.toString());


      return jsonResponse;

    }else if(response.statusCode==401){

      print('Invalid email or password');

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password'),
        duration: Duration(seconds: 4),
        backgroundColor:Colors.red ,
      ));
      throw Exception('Invalid email or password');
    }else if(response.statusCode==202){

      print('Account Blocked temporary');

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Account Blocked temporary'),
        duration: Duration(seconds: 4),
        backgroundColor:Colors.red ,
      ));
      throw Exception('Account Blocked temporary');
    }
    else {
      // Login failed
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['message'];
      print(responseJson['message']);
      throw Exception(errorMessage);
    }
  }




}