import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class RestServices {
  Future<Response> performGet(String endPoint, {Map<String, dynamic>? param});
  Future<Response> performPost(String endPoint, {Map<String, dynamic>? body, Map<String, dynamic>? param});
  loadToken({String? key});
  resetToken();
}

class RestService implements RestServices {
  final String url;
  late Dio dio;
  String? _token;
  RestService({required this.url, Dio ? dio}){
    this.dio = dio ?? Dio();
  }

  @override
  Future<Response> performGet(String endPoint, {Map<String, dynamic>? param}) {
    return dio.get(
      url + endPoint,
      queryParameters: param,
      options: Options(
        headers: {
          "Authorization": _token ?? '',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      )
    );
  }

  @override
  Future<Response> performPost(String endPoint, {Map<String, dynamic>? body, Map<String, dynamic>? param}) {
    return dio.post(
      url + endPoint,
      data: body,
      queryParameters: param,
      options: Options(
        headers: {
          "Authorization": _token ?? '',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      )
    );
  }

  @override
  loadToken({String? key}) async{
    if (this._token == null) {
      final str = "YOUR_CLIENT_ID:YOUR_SECRET_KEY";
      final bytes = utf8.encode(str);
      final base64Str = base64.encode(bytes);
      this._token = "Basic "+ base64Str;
    }
  }

  @override
  resetToken() {
    this._token = null;
  }
}

class CustomException implements Exception{
  final String message;
  CustomException({required this.message}): super();

  @override
  String toString() {
    return message;
  }
}

class DirectException implements Exception {
  final String message;
  DirectException({required this.message}): super();

  @override
  String toString() {
    return message;
  }
}