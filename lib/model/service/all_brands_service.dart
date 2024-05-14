import 'package:dio/dio.dart';
import 'package:info_ponsel/env.dart';
import 'package:info_ponsel/model/brands_model.dart'; // Import BrandModel

class AllBrandsService {
  Future<List<BrandModel>> fetchBrands() async {
    try {
      Response response = await Dio().get(
        'https://mobile-phones2.p.rapidapi.com/brands',
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                apiKey,
            'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
          },
        ),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> brandsJson =
            List<Map<String, dynamic>>.from(response.data);
        List<BrandModel> brands =
            brandsJson.map((json) => BrandModel.fromJson(json)).toList();

        // Urutkan berdasarkan nama brand
        brands.sort((a, b) {
          final aName = a.name ?? '';
          final bName = b.name ?? ''; 
          return aName.compareTo(bName);
        });

        // Hapus brand yang tidak memiliki nama
        brands
            .removeWhere((brand) => brand.name == null || brand.name!.isEmpty);

        return brands;
      } else {
        print('Error fetching all brands: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching all brands: $e');
      return [];
    }
  }
}
