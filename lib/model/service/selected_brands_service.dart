import 'package:dio/dio.dart';
import 'package:info_ponsel/model/brands_model.dart';

class SelectedBrandsService {
  static final Dio _dio = Dio();

  static Future<List<BrandModel>> fetchBrands(List<String> selectedBrands) async {
    try {
      _dio.options.headers = {
        'X-RapidAPI-Key': 'ba10f8876amsh724918adf1fdaecp147319jsn2cf56f4f34f3',
        'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
      };

      Response response = await _dio.get('https://mobile-phones2.p.rapidapi.com/brands');

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> brandsJson = List<Map<String, dynamic>>.from(response.data);
        List<BrandModel> brands = brandsJson
            .where((brand) => brand['name'] != null && selectedBrands.contains(brand['name']))
            .map((brand) => BrandModel.fromJson(brand))
            .toList();
        return brands;
      } else {
        throw Exception('Failed to fetch brands');
      }
    } catch (e) {
      print('Error fetching brands: $e');
      throw e; // Rethrow the error to propagate it further if needed
    }
  }
}

