import 'package:shared_preferences/shared_preferences.dart';

String token = 'token';

class SharedPref {
  static Future<void> createToken() async {
    

    // Simpan token di shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }


}
