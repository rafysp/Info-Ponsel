import 'package:dio/dio.dart';

class PonselTerbaruModel {
  final int brandId;
  final String brandName;
  final String id;
  final String phoneName;
  final String imageUrl;
  final String description;

  PonselTerbaruModel({
    required this.brandId,
    required this.brandName,
    required this.id,
    required this.phoneName,
    required this.imageUrl,
    required this.description,
  });

  factory PonselTerbaruModel.fromJson(Map<String, dynamic> json) {
    return PonselTerbaruModel(
      brandId: json['brand_id'] ?? 0,
      brandName: json['brand_name'] ?? '',
      id: json['id'] ?? '',
      phoneName: json['phone_name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
    );
  }

  static Future<List<List<PonselTerbaruModel>>> fetchPhoneModelsForAllBrands() async {
    List<int> brandIds = [9, 46, 48, 58, 80, 82, 98, 118, 119];
    List<List<PonselTerbaruModel>> allBrandPhoneModels = [];

    try {
      Dio dio = Dio();
      dio.options.headers.addAll({
        'X-RapidAPI-Key': '35218eb613mshbce9eb4ca7e7b5cp101623jsnf558459834f4',
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
