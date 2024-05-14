import 'dart:async';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static Gemini gemini = Gemini.instance;

  static Stream<String> getGeminiResponseStream(String question) {
    StreamController<String> controller = StreamController();

    gemini.streamGenerateContent(question).listen((event) {
      String response = event.content?.parts?.fold('',
              (previousValue, element) => '$previousValue${element.text}') ??
          '';
          // previousValue = nilai sebelumnya, element = elemen yang sedang diiterasi
          // untuk menggabungkan teks dari elemen-elemen yang ada dalam content.parts
      controller.add(response);
    }, onError: (error) {
      controller.addError(error);
    }, onDone: () {
      controller.close();
    });

    return controller.stream;
  }
}
