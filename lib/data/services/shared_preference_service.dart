import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesServices{
  saveString(String key, String value);

  saveInt(String key, int value);

  saveBoolean(String key, bool value);

  Future<String?> getString(String key);

  Future<bool?> getBool(String key);

  Future<int?> getInt(String key);

  clearAll();

  removeKey(String key);
}

//implement as Singleton
class SharedPreferencesService implements SharedPreferencesServices{
  SharedPreferences? _prefs;

  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  factory SharedPreferencesService(){
    return _instance;
  }

  SharedPreferencesService._internal() {}


  Future<SharedPreferences> _getInstance()async{
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      return _prefs!;
    }
    return _prefs!;
  }

  @override
  saveString(String key, String value) async {
    _prefs = await _getInstance();
    _prefs!.setString(key, value);
  }

  @override
  saveInt(String key, int value) async {
    _prefs = await _getInstance();
    _prefs!.setInt(key, value);
  }

  @override
  saveBoolean(String key, bool value) async {
    _prefs = await _getInstance();
    _prefs!.setBool(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    _prefs = await _getInstance();
    return _prefs!.getString(key);
  }

  @override
  Future<bool?> getBool(String key) async {
    _prefs = await _getInstance();
    return _prefs!.getBool(key);

  }

  @override
  Future<int?> getInt(String key) async {
    _prefs = await _getInstance();
    return _prefs!.getInt(key);
  }

  @override
  clearAll() async {
    _prefs = await _getInstance();
    await _prefs!.clear();
  }

  @override
  removeKey(String key) async{
    _prefs = await _getInstance();
    _prefs!.remove(key);
  }
}
