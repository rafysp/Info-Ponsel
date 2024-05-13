import 'package:dio/dio.dart';
import 'package:info_ponsel/env.dart';
import 'package:info_ponsel/model/phone_detail_model.dart';

class PhoneService {
  static Future<DetailPhone?> fetchPhoneDetail(String? phoneId) async {
    try {
      Response response = await Dio().get(
        'https://mobile-phones2.p.rapidapi.com/phones/$phoneId',
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                apiKey,
            'X-RapidAPI-Host': 'mobile-phones2.p.rapidapi.com',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;

        Map<String, List<AllSpec>> allSpecs = {};
        responseData['all_specs'].forEach((category, specs) {
          List<AllSpec> specList = [];
          specs.forEach((spec) {
            specList.add(AllSpec(
              title: spec['title'],
              info: spec['info'],
            ));
          });
          allSpecs[category] = specList;
        });

        return DetailPhone(
          allSpecs: allSpecs,
        );
      } else {
        // Tampilkan pesan error jika response tidak berhasil
        return null;
      }
    } catch (e) {
      // Tangani error saat melakukan request
      return null;
    }
  }
}
