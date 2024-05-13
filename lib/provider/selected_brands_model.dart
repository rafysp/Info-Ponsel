import 'package:flutter/material.dart';
import 'package:info_ponsel/model/brands_model.dart';
import 'package:info_ponsel/model/service/selected_brands_service.dart';

class SelectedBrandsProvider extends ChangeNotifier {
  List<BrandModel> _brands = []; // Menggunakan List<BrandModel>

  List<BrandModel> get brands => _brands;

  set brands(List<BrandModel> value) {
    _brands = value;
    notifyListeners(); // Memanggil notifyListeners() setelah pembaruan data
  }

  Future<void> fetchBrands(List<String> selectedBrands) async {
    try {
      // Panggil metode fetchBrands dari BrandService
      List<BrandModel> responseData = await SelectedBrandsService.fetchBrands(selectedBrands);

      // Setel nilai merek setelah berhasil mendapatkan data dari BrandService
      brands = responseData;
    } catch (e) {
      print('Error fetching brands: $e');
    }
  }
}
