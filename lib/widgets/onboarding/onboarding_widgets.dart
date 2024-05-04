import 'package:flutter/material.dart';

class OnboardingWidgets {
  static Widget widgetImage(String image) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static Widget widgetTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  static Widget widgetDescription(String description) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 295),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 9.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
