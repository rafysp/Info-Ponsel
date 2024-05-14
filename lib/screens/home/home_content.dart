import 'package:flutter/material.dart';
import 'package:info_ponsel/model/ponsel_terbaru_model.dart';
import 'package:info_ponsel/screens/carousel_news/carousel_slider.dart';
import 'package:info_ponsel/screens/favorite/favorite_page.dart';
import 'package:info_ponsel/screens/selected_brands/selected_brands.dart';
import 'package:info_ponsel/screens/ponsel_terbaru/ponsel_terbaru.dart';

class HomeContent extends StatelessWidget {
  final Future<List<List<PonselTerbaruModel>>> phoneModelsFuture;

  const HomeContent({
    Key? key,
    required this.phoneModelsFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: phoneModelsFuture,
        builder: (context, snapshot) {
          // Jika future belum selesai, tampilkan CircularProgressIndicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              // Tampilkan konten home
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Text(
                          'Info Ponsel',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 145.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritePage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.favorite_border),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const HomeCarouselSlider(),
                  const SizedBox(height: 20.0),
                  SelectedBrands(),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ponsel Terbaru',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder<List<List<PonselTerbaruModel>>>(
                    future: phoneModelsFuture,
                    builder: (context, snapshot) {
                      // Jika future belum selesai, tampilkan CircularProgressIndicator
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data!.map((brandPhoneModels) {
                              if (brandPhoneModels.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: PonselTerbaruCard(
                                    ponselTerbaruModel: brandPhoneModels.first,
                                  ),
                                );
                              } else {
                                return const SizedBox(); // Jika brandPhoneModels kosong, tidak menampilkan apapun
                              }
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
