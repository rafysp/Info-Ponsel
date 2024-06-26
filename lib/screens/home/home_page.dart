import 'package:flutter/material.dart';
import 'package:info_ponsel/model/ponsel_terbaru_model.dart';
import 'package:info_ponsel/model/service/ponsel_terbaru_service.dart';
import 'package:info_ponsel/screens/home/home_content.dart';
import 'package:info_ponsel/screens/recommendation/recommendation_page.dart';

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
  
      bottomNavigationBar: FutureBuilder<List<List<PonselTerbaruModel>>>(
        future: _phoneModelsFuture,
        builder: (context, snapshot) {
          // Jika future belum selesai, tampilkan BottomAppBar kosong
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BottomAppBar(
              child: Container(),
            );
          } else if (snapshot.hasError) {
            return BottomAppBar(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final bool homeContentLoading = _selectedIndex == 0 &&
                snapshot.connectionState != ConnectionState.done;

            if (homeContentLoading) {
              return BottomAppBar(
                child: Container(),
              );
            } else {
              return BottomNavigationBar(
                // Menambahkan BottomNavigationBarItem
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
              );
            }
          }
        },
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
