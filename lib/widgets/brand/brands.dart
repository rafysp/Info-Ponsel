import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:info_ponsel/all_brands_page.dart';
import 'package:info_ponsel/phonelist.dart';
import 'package:info_ponsel/widgets/brand/brands_card.dart';

class Brands extends StatefulWidget {
  final List<String> selectedBrands;
  Brands({Key? key, List<String>? selectedBrands})
      : selectedBrands = selectedBrands ??
            const [
              'Apple',
              'Samsung',
              'Xiaomi',
              'Oppo',
              'vivo',
              'Realme',
              'Asus',
              'Infinix',
              'Huawei',
            ],
        super(key: key);

  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  List<dynamic> brands = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchBrands() async {
    try {
      Response response = await Dio().get(
        'https://mobile-phones2.p.rapidapi.com/brands',
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                '35218eb613mshbce9eb4ca7e7b5cp101623jsnf558459834f4',
            'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
          },
        ),
      );
      setState(() {
        brands = response.data;
        brands = brands
            .where((brand) =>
                brand != null &&
                brand['name'] != null &&
                widget.selectedBrands.contains(brand['name']))
            .toList();
      });
    } catch (e) {
      print('Error fetching brands: $e');
    }
  }

  String brandNameToImagePath(String brandName) {
    String formattedBrandName = brandName.toLowerCase().replaceAll(' ', '');

    return 'assets/icons/$formattedBrandName.png';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 10.0, 
        children: [
          ...brands.map<Widget>((brand) {
            return BrandsCard(
              text: brand != null && brand['name'] != null ? brand['name'] : '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhoneListPage(
                      brandId: brand['id'].toString(),
                      brandName: brand['name'],
                    ),
                  ),
                );
              },
              imagePath: brand != null && brand['name'] != null
                  ? brandNameToImagePath(brand['name'])
                  : '',
            );
          }).toList(),
          InkWell(
            onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllBrandsPage(),
      ),
    );
  },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.more_horiz, 
                        color: Colors.black, 
                        size: 40, 
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'More',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
