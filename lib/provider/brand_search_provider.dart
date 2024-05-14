import 'package:flutter/material.dart';
import 'package:info_ponsel/model/service/all_brands_service.dart';

class BrandSearchProvider extends ChangeNotifier {
  List<dynamic> allBrands = [];
  List<dynamic> _filteredBrands = [];
  bool _isLoading = false;

  List<dynamic> get filteredBrands => _filteredBrands;
  bool get isLoading => _isLoading;

  set filteredBrands(List<dynamic> value) {
    _filteredBrands = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    setLoading(true); // Set loading ke true sebelum fetching data
    try {
      AllBrandsService brandService = AllBrandsService();
      List<dynamic> brands = await brandService.fetchBrands();
      allBrands = brands;
      filteredBrands = allBrands;
    } catch (e) {
      print('Error fetching all brands: $e');
    } finally {
      setLoading(false); // set loading ke false setelah selesai fetching data
    }
  }

  void searchBrands(String query) {
    _filteredBrands = allBrands
        .where(
            (brand) => brand.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
  }
}
