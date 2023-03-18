import 'dart:convert';

import 'package:ballerchain/view/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/const.dart';

class ForgetPasswordViewModel {
  Future<void> sendForgetPasswordEmail(
      BuildContext context, String email) async {
    final url = Uri.parse('$base_url/user/mdpoublier');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('A password reset email has been sent.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No user found with this email.'),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.red,
      ));
    } else {
      // The server returned an error status code
      final error = jsonDecode(response.body)['message'];
    }
  }
}
