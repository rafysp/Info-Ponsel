import 'package:dio/dio.dart';

class CarouselSliderItemModel {
  final String title;
  final String imageUrl;
  final String date;
  final String url;

  CarouselSliderItemModel({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.url,
  });

  factory CarouselSliderItemModel.fromJson(Map<String, dynamic> json) {
    return CarouselSliderItemModel(
      title: json['title'] ?? '',
      imageUrl: json['top_image'] ?? '',
      date: json['date'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

Future<List<CarouselSliderItemModel>> fetchCarouselSliderItems() async {
  try {
    Dio dio = Dio();
    Response response = await dio.post(
      "https://newsnow.p.rapidapi.com/newsv2_top_news_site",
      options: Options(
        headers: {
          "content-type": "application/json",
          "X-RapidAPI-Key":
              "35218eb613mshbce9eb4ca7e7b5cp101623jsnf558459834f4",
          "X-RapidAPI-Host": "newsnow.p.rapidapi.com",
        },
      ),
      data: {"language": "id", "site": "gadget.viva.co.id/gadget", "page": 1},
    );
    List<dynamic> responseData = response.data['news'];
    List<CarouselSliderItemModel> items = responseData.map((json) {
      return CarouselSliderItemModel.fromJson(json);
    }).toList();
    return items;
  } catch (error) {
    print('Error fetching carousel slider items: $error');
    return [];
  }
}
