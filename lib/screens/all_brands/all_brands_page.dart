import 'package:flutter/material.dart';
import 'package:info_ponsel/model/service/all_brands_service.dart';
import 'package:info_ponsel/screens/phone_list/phone_list_page.dart';
import 'package:info_ponsel/provider/brand_search_provider.dart';
import 'package:info_ponsel/screens/all_brands/widget/all_brands_card.dart';
import 'package:provider/provider.dart';

class AllBrandsPage extends StatefulWidget {
  @override
  _AllBrandsPageState createState() => _AllBrandsPageState();
}

class _AllBrandsPageState extends State<AllBrandsPage> {
  List<dynamic> allBrands = [];
  late List<dynamic> filteredBrands = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<BrandSearchProvider>(context, listen: false).setLoading(true);
    Provider.of<BrandSearchProvider>(context, listen: false).fetchData();
    fetchBrands();
  }

  void fetchBrands() async {
    AllBrandsService brandService = AllBrandsService();
    try {
      List<dynamic> brands = await brandService.fetchBrands();
      setState(() {
        allBrands = brands;
        filteredBrands = allBrands;
      });
    } catch (e) {
      print('Error fetching brands: $e');
    } finally {
      Provider.of<BrandSearchProvider>(context, listen: false)
          .setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brands'),
      ),
      body: Consumer<BrandSearchProvider>(
        builder: (context, brandSearchProvider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      // Fitur untuk mencari brand
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) =>
                            brandSearchProvider.searchBrands(query),
                        decoration: InputDecoration(
                          labelText: 'Search Brands',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        brandSearchProvider.searchBrands('');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                // Fitur untuk menampilkan daftar brand
                child: (() {
                  if (brandSearchProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (brandSearchProvider.filteredBrands.isEmpty) {
                    return const Center(
                      child: Text('No brands found'),
                    );
                  } else {
                    return Scrollbar(
                      thumbVisibility: true,
                      interactive: true,
                      thickness: 10,
                      radius: const Radius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GridView.builder(
                          // Gridview untuk menampilkan daftar brand
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 15.0,
                          ),
                          // Menggunakan provider untuk mendapatkan daftar brand yang sudah difilter
                          itemCount: brandSearchProvider.filteredBrands.length,
                          itemBuilder: (context, index) {
                            var brand =
                                brandSearchProvider.filteredBrands[index];
                            return brand != null &&
                                    brand.name != null &&
                                    brand.name != ""
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PhoneListPage(
                                            brandId: brand.id,
                                            brandName: brand.name,
                                          ),
                                        ),
                                      );
                                    },
                                    child: AllBrandsCard(
                                      name: brand.name,
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                    );
                  }
                })(),
              ),
            ],
          );
        },
      ),
    );
  }
}

String brandNameToImagePath(String brandName) {
  String formattedBrandName = brandName.toLowerCase().replaceAll(' ', '');

  return 'assets/img/brands/$formattedBrandName.png';
}
