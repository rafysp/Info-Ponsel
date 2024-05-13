import 'package:flutter/material.dart';
import 'package:info_ponsel/pages/all_brands_page.dart';
import 'package:info_ponsel/pages/phone_list_page.dart';
import 'package:info_ponsel/provider/selected_brands_model.dart';
import 'package:info_ponsel/widgets/brands_card.dart';
import 'package:provider/provider.dart';

class Brands extends StatelessWidget {
  final List<String> selectedBrands;
  Brands({Key? key, List<String>? selectedBrands})
      : selectedBrands = selectedBrands ??
            const [
              'Apple',
              'Samsung',
              'Xiaomi',
              'Oppo',
              'vivo',
              'Realme',
              'Asus',
              'Infinix',
              'Huawei',
            ],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedBrandsProvider(),
      child: BrandsContent(selectedBrands: selectedBrands),
    );
  }
}

class BrandsContent extends StatefulWidget {
  final List<String> selectedBrands;

  const BrandsContent({Key? key, required this.selectedBrands})
      : super(key: key);

  @override
  _BrandsContentState createState() => _BrandsContentState();
}

class _BrandsContentState extends State<BrandsContent> {
  @override
  void initState() {
    super.initState();
    final brandModel = context.read<SelectedBrandsProvider>();
    brandModel.fetchBrands(widget.selectedBrands);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedBrandsProvider>(
      builder: (context, brandModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 10.0,
            children: [
              ...brandModel.brands.map<Widget>((brand) {
                return BrandsCard(
                  // ignore: unnecessary_null_comparison
                  text: brand != null ? brand.name! : '',
                  imagePath:
                      // ignore: unnecessary_null_comparison
                      brand != null ? brandNameToImagePath(brand.name!) : '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneListPage(
                          brandId: brand.id!,
                          brandName: brand.name!,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllBrandsPage(),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'More',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String brandNameToImagePath(String brandName) {
    String formattedBrandName = brandName.toLowerCase().replaceAll(' ', '');
    return 'assets/img/brands/$formattedBrandName.png';
  }
}