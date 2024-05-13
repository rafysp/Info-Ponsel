import 'package:dio/dio.dart';
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
                "35218eb613mshbce9eb4ca7e7b5cp101623jsnf558459834f4", // Ganti dengan API key Anda
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
