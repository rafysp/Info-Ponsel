import 'package:flutter/material.dart';
import 'package:info_ponsel/screens/home/home_page.dart';
import 'package:info_ponsel/model/onboarding_page_model.dart';
import 'package:info_ponsel/utils/onboarding_utils.dart';
import 'package:info_ponsel/screens/onboarding/widget/onboarding_widgets.dart';

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
            'Temukan ponsel yang tepat sesuai kebutuhan dengan fitur rekomendasi ponsel kami.',
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
  body: OnboardingPagePresenter(
    pages: onboardingPages,
    currentPage: 0,
    pageController: PageController(initialPage: 0),
  ),
);

  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final PageController pageController;

  const OnboardingPagePresenter({
    Key? key,
    required this.pages,
    required this.pageController, required int currentPage,
  }) : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPagePresenterState();
}

class _OnboardingPagePresenterState extends State<OnboardingPagePresenter> {
  int _currentPage = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        // Fungsi untuk mengubah warna background
        duration: const Duration(milliseconds: 250),
        color: _currentPage < widget.pages.length
            ? widget.pages[_currentPage].bgColor
            : Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: widget.pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx; 
                    });
                  },
                  itemBuilder: (context, idx) {
                    return OnboardingWidget(page: widget.pages[idx]);
                  },
                ),
              ),
              Row(
                // Fungsi untuk menampilkan indikator halaman
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .asMap()
                    .entries
                    .map(
                      (entry) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: _currentPage == entry.key ? 30 : 8,
                        height: 8,
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                // Fungsi untuk menampilkan tombol Skip dan Next
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
                        final int nextPage = _currentPage + 1;
                        if (nextPage == widget.pages.length) {
                          // Jika halaman terakhir, maka navigasi ke halaman Home
                          SharedPref.createToken();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          widget.pageController.animateToPage(
                            nextPage,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1 ? "Finish" : "Next",
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
