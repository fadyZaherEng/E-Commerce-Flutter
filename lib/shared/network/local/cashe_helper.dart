import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<bool> save({
    required dynamic value,
    required String key,
  }){
    if(value is bool) return sharedPreferences.setBool(key, value);
    if(value is String) return sharedPreferences.setString(key, value);
    if(value is int) {
      return sharedPreferences.setInt(key, value);
    } else {
      return sharedPreferences.setDouble(key, value);
    }
  }
  static dynamic get({
    required String key,
  }){
    return sharedPreferences.get(key) ;
  }

  static Future<bool> remove({
    required String key,
  }){
    return sharedPreferences.remove(key);
  }
}