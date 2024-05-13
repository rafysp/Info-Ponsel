import 'package:flutter/material.dart';
import 'package:info_ponsel/model/service/gemini_ai_service.dart';

class RecommendationModel extends ChangeNotifier {
  late TextEditingController budgetController;
  List<String?> selectedPriorities = [];
  List<String> recommendationList = []; 
  bool isLoading = false;
  String combined = ' ';

  RecommendationModel() {
    budgetController = TextEditingController();
  }

  bool isValidBudget(BuildContext context) {
    String budgetText =
        budgetController.text.replaceAll('.', '').replaceAll(',', '');

    if (budgetText.isEmpty || double.parse(budgetText) < 900000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan budget yang sesuai (Minimal IDR 900,000).'),
        ),
      );
      return false;
    }
    return true;
  }

  void getRecommendation(
      String budget, List<String?> priorities, BuildContext context) {
    if (!isValidBudget(context)) {
      return;
    }
    isLoading = true;
    recommendationList.clear();

    String question =
        'Beri saya rekomendasi smartphone terbaru dengan Budget: IDR $budget, untuk kebutuhan $priorities.';

    GeminiService.getGeminiResponseStream(question).listen(
      (response) {
        String cleanedResponse = response
            .replaceAll('**', '')
            .replaceAll('*', ''); // Membersihkan respons dari karakter yang tidak diinginkan
        recommendationList
            .add(cleanedResponse); // Menambahkan respons ke dalam list

        isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        print('Error from Gemini: $error');
      },
    );
  }

  void clearRecommendation() {
    recommendationList.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  void addPriority(String? priority) {
    selectedPriorities.add(priority);
    notifyListeners();
  }

  void removePriority(int index) {
    selectedPriorities.removeAt(index);
    notifyListeners();
  }
}
