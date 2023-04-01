import 'dart:convert';
import 'package:ballerchain/view/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
//import '../Res/AppColors.dart';
import '../Utils/const.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/interceptors/dio_interceptor.dart';



class LoginViewModel{

  Future<dynamic> login(BuildContext context, String firstname,String password) async {
    final preferences= await  SharedPreferences.getInstance();
    final url = Uri.parse('$base_url/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstname': firstname,
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