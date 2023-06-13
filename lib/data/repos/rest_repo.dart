import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:test_test/consts/error_consts.dart';
import 'package:test_test/data/models/passport_dto.dart';
import 'package:test_test/data/services/rest_service.dart';


abstract class RestRepos{
  Future<Response> postPassportInformation({required PassportDto passportDto});
  Future<Response> requestStatus();
}

class RestRepo implements RestRepos{
  final RestServices restServices;

  RestRepo({ required this.restServices});

  @override
  Future<Response> postPassportInformation({required PassportDto passportDto}) async {
    try {
      var rng = Random();
      Map<String, Object> payload = {
        "reference": (rng.nextInt(900000) + 100000 ).toString(),
        "language": "EN",
        "email": "",
        "verification_mode": "image_only",
        "show_consent": 1,
        "show_results": 1,
        "show_privacy_policy": 1,
        "open_webView": false,
      };
      payload["document"] = passportDto.jsonForm();
      await restServices.loadToken();
      Response result = await restServices.performPost("", body: payload).timeout(Duration(seconds: 20), onTimeout: () => throw CustomException(message: ErrorConst.UNKNOWN_SERVER_ERROR));
      if (result.statusCode == 200) {
        return new Response(requestOptions: RequestOptions(method: "content-type"));
      } else if (result.statusCode == 401){
        throw DirectException(message: ErrorConst.NOT_VALID_AUTH_PROVIDE);
      } else if (result.statusCode == 400) {
        throw DirectException(message: ErrorConst.NOT_ALLOWED_SERVICE);
      } else if (result.statusCode == 500) {
        throw DirectException(message: ErrorConst.SERVER_ERROR);
      } else {
        throw DirectException(message: ErrorConst.UNKNOWN_SERVER_ERROR);
      }
    } on CustomException catch(e) {
      throw new CustomException(message: e.message);
    } on DirectException catch(e) {
      throw DirectException(message: e.message);
    } catch(e) {
      throw CustomException(message: ErrorConst.UNKNOWN_SERVER_ERROR);
    }
  }

  @override
  Future<Response> requestStatus() async{
    try {
      var rng = Random();
      Map<String,dynamic> payload = {
        "reference": (rng.nextInt(900000) + 100000 ).toString(),
      };
      await restServices.loadToken();
      Response result = await restServices.performPost("/status", body: payload).timeout(Duration(seconds: 10), onTimeout: () => throw CustomException(message: ErrorConst.UNKNOWN_SERVER_ERROR));
      if (result.statusCode == 200) {
        return new Response(requestOptions: RequestOptions(method: "content-type"));
      }
      else {
        print(result.statusCode);
        throw DirectException(message: ErrorConst.NOT_VALID_AUTH_PROVIDE);
      }
    } on CustomException catch(e) {
      throw new CustomException(message: e.message);
    } on DirectException catch(e) {
      throw DirectException(message: e.message);
    } catch(e) {
      throw CustomException(message: ErrorConst.UNKNOWN_SERVER_ERROR);
    }
  }
}
