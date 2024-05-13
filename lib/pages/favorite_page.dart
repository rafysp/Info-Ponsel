import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:info_ponsel/model/service/all_brands_service.dart';
import 'package:info_ponsel/pages/phone_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_ponsel/widgets/favorite_list_tile.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> favoritePhones = [];

  @override
  void initState() {
    super.initState();
    loadFavoritePhones();
  }

  Future<void> loadFavoritePhones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePhonesJson =
        prefs.getStringList('favorite_phones') ?? [];

    setState(() {
      favoritePhones = favoritePhonesJson
          .map((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> removeFromFavorites(String phoneId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePhonesJson =
        prefs.getStringList('favorite_phones') ?? [];

    favoritePhonesJson.removeWhere((jsonString) {
      Map<String, dynamic> phone = jsonDecode(jsonString);
      return phone['phoneId'] == phoneId;
    });

    await prefs.setStringList('favorite_phones', favoritePhonesJson);
    setState(() {
      favoritePhones = favoritePhonesJson
          .map((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Phones'),
      ),
      body: favoritePhones.isEmpty
          ? const Center(
              child: Text('No favorite phones yet'),
            )
          : ListView.builder(
              itemCount: favoritePhones.length,
              itemBuilder: (context, index) {
                final phone = favoritePhones[index];
                return FavoriteListTile(
                  phone: phone,
                  onRemove: removeFromFavorites,
                );
              },
            ),
    );
  }
}
