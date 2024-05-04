import 'package:flutter/material.dart';
import 'package:info_ponsel/pages/home_page.dart';
import 'package:info_ponsel/pages/onboarding/onboarding_page_model.dart';
import 'package:info_ponsel/utils/shared_pref.dart';
import 'package:info_ponsel/widgets/onboarding/onboarding_widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPageModel> onboardingPages = [
      OnboardingPageModel(
        title: 'Telusuri Spesifikasi Ponsel',
        description:
            'Dapatkan informasi spesifikasi ponsel dengan cepat dan mudah.',
        image: 'assets/img/onboarding/onboarding_3.png',
        bgColor: Colors.indigo,
      ),
      OnboardingPageModel(
        title: 'Temukan yang Tepat',
        description:
            'Temukan ponsel yang tepat dengan fitur perbandingan kami.',
        image: 'assets/img/onboarding/onboarding_1.png',
        bgColor: const Color(0xff1eb090),
      ),
      OnboardingPageModel(
        title: 'Simpan untuk Nanti',
        description:
            'Simpan ponsel yang menarik hati Anda untuk diakses kembali.',
        image: 'assets/img/onboarding/onboarding_4.png',
        bgColor: const Color(0xfffeae4f),
      ),
    ];

    return Scaffold(
      body: OnboardingPagePresenter(pages: onboardingPages),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPagePresenter({Key? key, required this.pages})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: _currentPage < widget.pages.length
            ? widget.pages[_currentPage].bgColor
            : Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        OnboardingWidgets.widgetImage(item.image),
                        OnboardingWidgets.widgetTitle(item.title),
                        OnboardingWidgets.widgetDescription(item.description),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        SharedPref.createToken();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: const Text("Skip"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          SharedPref.createToken();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Finish"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == widget.pages.length - 1
                                ? Icons.done
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
