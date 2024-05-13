import 'package:dio/dio.dart';
import 'package:info_ponsel/env.dart';
import 'package:info_ponsel/model/carousel_slider_model.dart';

class CarouselSliderService {
  static Future<List<CarouselSliderItemModel>>
      fetchCarouselSliderItems() async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        "https://newsnow.p.rapidapi.com/newsv2_top_news_site",
        options: Options(
          headers: {
            "content-type": "application/json",
            "X-RapidAPI-Key":
                "$newsApiKey", 
            "X-RapidAPI-Host": "newsnow.p.rapidapi.com",
          },
        ),
        data: {
          "language": "id",
          "site": "gadget.viva.co.id/gadget",
          "page": 1,
        },
      );

      List<Map<String, dynamic>> responseData =
          List<Map<String, dynamic>>.from(response.data['news']);
      responseData
          .removeWhere((item) => item['title'].toLowerCase().contains('mod'));

      List<CarouselSliderItemModel> carouselItems = responseData
          .map((item) => CarouselSliderItemModel.fromJson(item))
          .toList();

      return carouselItems;
    } catch (error) {
      throw error;
    }
  }
}
