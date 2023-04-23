import 'dart:io';
import 'package:ballerchain/common/theme_helper.dart';
import 'package:ballerchain/main.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../model/user.dart';
import '../utils/const.dart';

class SignUpViewModel {
  Future<User> signup(User user) async {
    final url = '$base_url/user';


    final imageFile = File(user.image!);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      user.image!,
      contentType: MediaType('image', 'jpg'),
    ));
    request.fields['firstname'] = user.firstname!;
    request.fields['lastname'] = user.lastname!;
    request.fields['email'] = user.email!;
    request.fields['phonenumber'] = user.phonenumber!;
    request.fields['birthday'] = user.birthday!;
    request.fields['password'] = user.password!;

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('ajout avec succee');


      return user;
    } else {
      print(response.body);
      throw Exception("Failed to sign up");
    }
  }
}
