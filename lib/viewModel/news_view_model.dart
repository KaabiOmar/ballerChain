import 'dart:convert';

import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/news.dart';
import 'package:ballerchain/model/user.dart';
import 'package:http/http.dart' as http;


class NewsViewModel {
  final url = Uri.parse('$base_url/user/news');

  Future<List<News>> getNews() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<News> news = data.map((newss) => News.fromJson(newss)).toList();
        return news;
      //  final jsonData = jsonDecode(response.body);
      //  return jsonData;
      } else {
        throw Exception('Failed to get news');
      }
    } catch (error) {
      throw error;
    }
  }
}
