import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static bool isPhoneAlreadyFavorite(String phoneId, List<String> favoritePhonesJson) {
    for (String jsonString in favoritePhonesJson) {
      Map<String, dynamic> phone = jsonDecode(jsonString);
      if (phone['phoneId'] == phoneId) {
        return true;
      }
    }
    return false;
  }

  static Future<void> addToFavorites(String phoneId, String imageUrl, String phoneName, String? description, String? brandName, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoritePhonesJson = prefs.getStringList('favorite_phones') ?? [];

      if (!isPhoneAlreadyFavorite(phoneId, favoritePhonesJson)) {
        favoritePhonesJson.add(jsonEncode({
          'phoneId': phoneId,
          'imageUrl': imageUrl,
          'phoneName': phoneName,
          'description': description ?? '',
          'brandName': brandName,
        }));

        await prefs.setStringList('favorite_phones', favoritePhonesJson);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to favorites')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone is already in favorites')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to favorites')),
      );
    }
  }
}
