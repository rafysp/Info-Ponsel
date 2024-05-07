import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:info_ponsel/widgets/carousel/carousel_slider_item.dart';
import 'package:info_ponsel/widgets/carousel/carousel_slider_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({Key? key}) : super(key: key);

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  late final PageController _pageController;
  int _pageIndex = 0;
  late Timer _timer;

  List<CarouselSliderItemModel> carouselSliderItems = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1000,
      viewportFraction: 0.8,
    );
    fetchData();
    _startTimer(); 
  }

  Future<void> fetchData() async {
  
    List<CarouselSliderItemModel> items = await fetchCarouselSliderItems();
    setState(() {
      carouselSliderItems = items;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index % 9;
          });
        },
        controller: _pageController,
        itemBuilder: (context, index) {
          final i = index % 9;
          if (carouselSliderItems.isNotEmpty &&
              i < carouselSliderItems.length) {
            return CarouselSliderItem(
              isActive: i == _pageIndex,
              item: carouselSliderItems[i],
            );
          } else {
            return Container(
              color: Colors.grey[400],
              margin: const EdgeInsets.all(10.0),
              child: const Placeholder(),
            );
          }
        },
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

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
        duration: Duration(milliseconds: 400),
        scale: isActive ? 1 : 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: () async {},
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      child: Center(),
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
                        item.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        item.date,
                        style: TextStyle(
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
