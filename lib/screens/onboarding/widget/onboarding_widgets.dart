import 'package:flutter/material.dart';
import 'package:info_ponsel/model/onboarding_page_model.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingWidget({
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              page.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            page.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 9.0),
          child: Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
