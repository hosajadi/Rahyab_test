import 'dart:convert';
import 'package:test_test/consts/data_const.dart';
import '../services/shared_preference_service.dart';

abstract class SharedPreferencesRepos{
  Future<String?>getSavedTokenInfo();
  Future<void> saveTokenInfo(String token);
}

class SharedPreferencesRepo implements SharedPreferencesRepos{
  late SharedPreferencesServices sharedPreferencesServices;
  SharedPreferencesRepo({SharedPreferencesServices? sharedPreferencesServices}){
    this.sharedPreferencesServices = sharedPreferencesServices ?? SharedPreferencesService();
  }
  
  @override
  Future<String?>getSavedTokenInfo() async {
    String? tokenInfoString = await this.sharedPreferencesServices.getString(DataConst.TOKEN_INFO);
    if (tokenInfoString == null){
      return null;
    }
    return tokenInfoString;
  }

  @override
  Future<void> saveTokenInfo(String token) async {
    String tokenString = jsonEncode(token);
    await sharedPreferencesServices.saveString(DataConst.TOKEN_INFO, tokenString);
  }
}