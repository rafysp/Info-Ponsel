import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> createToken() async {
    // Buat token baru (misalnya, menggunakan UUID)
    String token = 'generated_token_here'; // Ganti dengan pembangkitan token yang sesuai

    // Simpan token di shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }


}
