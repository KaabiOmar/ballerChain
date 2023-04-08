
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ballerchain/Utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


class AdminViewModel {


  Future<String> deleteUser(BuildContext context,String userId) async {
    final url = Uri.parse('$base_url/user/delete/$userId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
       print("user deleted successfully");

       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text('user deleted'),
         duration: Duration(seconds: 4),
         backgroundColor:Colors.red ,
       ));

       return userId ;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<String> blockUser(BuildContext context,String userId) async {
    final url = Uri.parse('$base_url/user/block/$userId');
    try {
      final response = await http.put(url);

      if (response.statusCode == 200) {
        print("user Blocked");

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User Blocked'),
          duration: Duration(seconds: 4),
          backgroundColor:Colors.red ,
        ));

        return userId ;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<String> unblockUser(BuildContext context,String userId) async {
    final url = Uri.parse('$base_url/user/unblock/$userId');
    try {
      final response = await http.put(url);

      if (response.statusCode == 200) {
        print("user Unblocked");

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User Unblocked'),
          duration: Duration(seconds: 4),
          backgroundColor:Colors.green ,
        ));

        return userId ;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
