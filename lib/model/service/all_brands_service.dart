import 'package:dio/dio.dart';
import 'package:info_ponsel/model/brands_model.dart'; // Import BrandModel

class AllBrandsService {
  Future<List<BrandModel>> fetchBrands() async {
    try {
      Response response = await Dio().get(
        'https://mobile-phones2.p.rapidapi.com/brands',
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                'ba10f8876amsh724918adf1fdaecp147319jsn2cf56f4f34f3',
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
          final aName = a.name ?? ''; // Use empty string as default if null
          final bName = b.name ?? ''; // Use empty string as default if null
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
