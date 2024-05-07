import 'package:flutter/material.dart';
import 'package:info_ponsel/widgets/brand/brands.dart';
import 'package:info_ponsel/widgets/carousel/carousel_slider.dart';
import 'package:info_ponsel/widgets/ponsel_terbaru/ponsel_terbaru_card.dart';
import 'package:info_ponsel/widgets/ponsel_terbaru/ponsel_terbaru_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<List<PonselTerbaruModel>>> _phoneModelsFuture;

  @override
  void initState() {
    super.initState();
    _phoneModelsFuture = PonselTerbaruModel.fetchPhoneModelsForAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          hintText: 'Cari...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(width: 45.0),
                    InkWell(
                      onTap: () {},
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
              const SizedBox(height: 20.0),
              HomeCarouselSlider(),
              SizedBox(height: 20.0),
              Brands(),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Ponsel Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<List<PonselTerbaruModel>>>(
                  future: _phoneModelsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      return Row(
                        children: snapshot.data!.map((brandPhoneModels) {
                          if (brandPhoneModels.isNotEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: PonselTerbaruCard(
                                ponselTerbaruModel: brandPhoneModels.first,
                              ),
                            );
                          } else {
                            return SizedBox(); // Jika brandPhoneModels kosong, tidak menampilkan apapun
                          }
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
