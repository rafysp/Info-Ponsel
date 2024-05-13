import 'package:dio/dio.dart';
import 'package:info_ponsel/env.dart';
import 'package:info_ponsel/model/ponsel_terbaru_model.dart';

class PonselTerbaruService {
  static Future<List<List<PonselTerbaruModel>>>
      fetchPhoneModelsForSelectedBrands() async {
    List<int> brandIds = [9, 46, 48, 58, 80, 82, 98, 118, 119];
    List<List<PonselTerbaruModel>> allBrandPhoneModels = [];

    try {
      Dio dio = Dio();
      dio.options.headers.addAll({
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
      });

      for (int brandId in brandIds) {
        Response response = await dio.get(
          'https://mobile-phones2.p.rapidapi.com/$brandId/phones',
        );

        if (response.statusCode == 200) {
          List<dynamic> data = response.data['data'] ?? [];
          List<PonselTerbaruModel> brandPhoneModels =
              data.map((json) => PonselTerbaruModel.fromJson(json)).toList();
          allBrandPhoneModels.add(brandPhoneModels);
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error fetching phone models: $e');
    }

    return allBrandPhoneModels;
  }
}
