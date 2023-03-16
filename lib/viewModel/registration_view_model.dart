
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../utils/const.dart';

class SignUpViewModel{
  Future<User> signup(User user) async {
    final url = '$base_url/user';
    final dio = Dio();


    final imageFile = File(user.image!);

    FormData formData = FormData.fromMap({
      'firstname': user.firstname,
      'lastname': user.lastname,
      'email': user.email,
      'phonenumber': user.phonenumber,
      'birthday': user.birthday,
      'password': user.password,
      'image': await MultipartFile.fromFile(user.image!,filename:'image.jpg',),

    });

    var response = await dio.post(url, data: formData,options: Options(
        contentType: 'multipart/form-data'));

    if (response.statusCode == 200) {
      print('success');
      return user;
    } else {
      print(response.data);
      throw Exception("Failed to sign up");
    }

  }


/*Future<User> signup(User user) async {
    final url = Uri.parse('$base_url/user/');
    final request = http.MultipartRequest('POST', url);

    request.fields['firstname'] = user.firstname;
    request.fields['lastname'] = user.lastname;
    request.fields['phone'] = user.phoneNumber;
    request.fields['email'] = user.email;
    request.fields['password'] = user.password;
    request.fields['role'] = user.role;
    request.fields['gender'] = user.gender!;
    request.fields['dateofbirth'] = user.dateOfBirth.toString();


    /*    request.fields['fullname'] = user.firstname;
    request.fields['username'] = user.lastname;
    request.fields['phoneNumber'] = user.phoneNumber;
    request.fields['email'] = user.email;
    request.fields['password'] = user.password;
    request.fields['role'] = user.role;*/

    final imageFile = File(user.imageUser!);

    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();
    final multipartFile = http.MultipartFile(
      'imageUser',
      fileStream,
      fileLength,
      filename: imageFile.path.split('/').last,

    );
    request.files.add(multipartFile);

    print("image file added to request: ${request.files[0].filename}");

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();;
      if (response.statusCode == 201) {
        print('succes');

        return user;
      } else {

        print(responseBody);
        throw Exception("noooooooooooooo");
      }

  }*/


}