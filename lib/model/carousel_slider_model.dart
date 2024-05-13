import 'package:info_ponsel/model/service/carousel_slider_service.dart';

class CarouselSliderItemModel {
  String? title;
  String? imageUrl;
  String? date;
  String? url;

  CarouselSliderItemModel({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.url,
  });

  CarouselSliderItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['top_image'];
    date = json['date'];
    url = json['url'];
  }

  static Future<List<CarouselSliderItemModel>>
      fetchCarouselSliderItems() async {
    try {
      List<CarouselSliderItemModel> carouselItems =
          await CarouselSliderService.fetchCarouselSliderItems();

      return carouselItems;
    } catch (error) {
      print('Error fetching carousel slider items: $error');
      throw error;
    }
  }
}
