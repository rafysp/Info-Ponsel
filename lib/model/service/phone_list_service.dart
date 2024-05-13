import 'package:dio/dio.dart';
import 'package:info_ponsel/model/phone_list_model.dart';

class PhoneListService {
  static Future<List<PhoneListModel>> fetchPhonesByBrand(int brandId, int page, int pageSize) async {
    try {
      Response response = await Dio().get(
        'https://mobile-phones2.p.rapidapi.com/$brandId/phones',
        queryParameters: {'page': page, 'pageSize': pageSize},
        options: Options(
          headers: {
            'X-RapidAPI-Key': 'ba10f8876amsh724918adf1fdaecp147319jsn2cf56f4f34f3',
            'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
          },
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data.containsKey('data')) {
          List<dynamic> phonesData = data['data'];
          List<PhoneListModel> phones = phonesData.map((phoneData) {
            return PhoneListModel(
              id: phoneData['id'].toString(),
              phoneName: phoneData['phone_name'] ?? '',
              description: phoneData['description'] ?? '',
              imageUrl: phoneData['image_url'] ?? '',
            );
          }).toList();
          return phones;
        } else {
          print('Error: Key "data" not found in API response');
          return [];
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching phones: $e');
      return [];
    }
  }
}
