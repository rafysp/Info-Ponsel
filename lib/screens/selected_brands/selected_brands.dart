import 'package:flutter/material.dart';
import 'package:info_ponsel/screens/all_brands/all_brands_page.dart';
import 'package:info_ponsel/screens/phone_list/phone_list_page.dart';
import 'package:info_ponsel/provider/selected_brands_model.dart';
import 'package:info_ponsel/screens/selected_brands/widget/seleceted_brands_card.dart';
import 'package:provider/provider.dart';

class SelectedBrands extends StatelessWidget {
  final List<String> selectedBrands;
  SelectedBrands({Key? key, List<String>? selectedBrands})
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
              // ... Operator Spread
              ...brandModel.brands.map<Widget>((brand) {
                return SelectedBrandsCard(
                  text: brand.name ?? '',
                  imagePath: brandNameToImagePath(brand.name!),
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
