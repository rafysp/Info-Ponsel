import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:info_ponsel/env.dart';
import 'package:info_ponsel/model/recommendation_model.dart';
import 'package:info_ponsel/screens/splashpage/splash_page.dart';
import 'package:info_ponsel/provider/brand_search_provider.dart';
import 'package:info_ponsel/provider/selected_brands_model.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(apiKey: geminiKey); // Inisialisasi API Key
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecommendationModel()),
        ChangeNotifierProvider(create: (_) => SelectedBrandsProvider()),
        ChangeNotifierProvider(create: (_) => BrandSearchProvider()),
      ],
      child: MaterialApp(
        title: 'My App',
        home: SplashPage(),
      ),
    );
  }
}
