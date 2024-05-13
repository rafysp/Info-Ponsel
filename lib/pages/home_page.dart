import 'package:flutter/material.dart';
import 'package:info_ponsel/model/ponsel_terbaru_model.dart';
import 'package:info_ponsel/model/service/ponsel_terbaru_service.dart';
import 'package:info_ponsel/pages/home_content.dart';
import 'package:info_ponsel/pages/recommendation_page.dart';
import 'package:info_ponsel/pages/selected_brands.dart';
import 'package:info_ponsel/pages/carousel_slider.dart';
import 'package:info_ponsel/widgets/ponsel_terbaru_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<List<PonselTerbaruModel>>> _phoneModelsFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _phoneModelsFuture =
        PonselTerbaruService.fetchPhoneModelsForSelectedBrands();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recommendation',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeContent(phoneModelsFuture: _phoneModelsFuture),
          RecommendationPage(),
        ],
      ),
    );
  }
}
