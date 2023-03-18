
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  const SharedPreference._();
  static const String _tokenKey="TOKEN";
  static const String _userIdKey="_USERID"; // Ajouter une clé pour stocker l'id

  static Future<void> setToken(String token)async{
    final preferences=await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey,token);
  }

  static Future<String?> getToken() async{
    final preferences=await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<void> setUserId(String userId) async { // Ajouter la méthode setUserId
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async { // Ajouter la méthode getUserId
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userIdKey);
  }
  static Future<void> clear()async{
    final preferences=await SharedPreferences.getInstance();
    await preferences.clear();
  }
}