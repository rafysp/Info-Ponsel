import 'package:flutter/material.dart';
import 'package:info_ponsel/model/carousel_slider_model.dart';
import 'package:info_ponsel/screens/in_app_webview/inappwebview_page.dart';

class CarouselSliderItem extends StatelessWidget {
  final CarouselSliderItemModel item;
  final bool isActive;

  const CarouselSliderItem({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.08,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: isActive ? 1 : 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => InAppWebViewPage(
                          url: item.url!,
                        )),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  // Jika terjadi error saat memuat gambar, tampilkan icon error
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        item.date!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
