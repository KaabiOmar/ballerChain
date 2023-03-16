
import 'package:dio/dio.dart';
import 'package:ballerchain/utils/shared_preference.dart';

class DioInterceptor extends Interceptor {
  Dio dio = Dio();

  DioInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async{
        final token = await SharedPreference.getToken();
        // modify request options
        if (token!=null && token.isNotEmpty){
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options); // continue with the request
        }},
      onResponse: (response, handler) {
        // modify response
        print(response.data);
        return handler.next(response); // continue with the response
      },
      onError: (error, handler) {
        // handle errors
        return handler.next(error); // continue with the error
      },
    ));
  }
}