import 'dart:async';
import 'package:flutter/material.dart';
import 'package:info_ponsel/model/carousel_slider_model.dart';
import 'package:info_ponsel/screens/carousel_news/widget/carousel_slider_item.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({Key? key}) : super(key: key);

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  late PageController _pageController;
  int _pageIndex = 0;
  late Timer _timer;
  bool _isLoading = false;

  List<CarouselSliderItemModel> carouselSliderItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CarouselSliderItemModel> items =
          await CarouselSliderItemModel.fetchCarouselSliderItems();
      setState(() {
        carouselSliderItems = items;
        _isLoading = false;
        _pageController = PageController(
          initialPage: 0,
          viewportFraction: 0.8,
        );
      });

      // Delay 500 milliseconds sebelum memulai timer
      await Future.delayed(Duration(milliseconds: 500));
      _startTimer();
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching carousel slider items: $error');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index % 7;
                });
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                final i = index % 7;
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


