import 'package:flutter/material.dart';
import 'package:info_ponsel/model/phone_detail_model.dart';
import 'package:info_ponsel/model/service/phone_detail_service.dart';
import 'package:info_ponsel/utils/favorite_utils.dart';
import 'package:info_ponsel/screens/phone_detail/widget/spec_section_widget.dart';

class PhoneDetailPage extends StatefulWidget {
  final String? phoneId;
  final String? imageUrl;
  final String? phoneName;
  final String? description;
  final String? brandName;

  PhoneDetailPage({
    required this.phoneId,
    required this.imageUrl,
    required this.phoneName,
    required this.description,
    required this.brandName,
  });

  @override
  _PhoneDetailPageState createState() => _PhoneDetailPageState();
}

class _PhoneDetailPageState extends State<PhoneDetailPage> {
  late DetailPhone phoneDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhoneDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text(widget.phoneName!)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              FavoriteService.addToFavorites(
                widget.phoneId!,
                widget.imageUrl!,
                widget.phoneName!,
                widget.description!,
                widget.brandName!,
                context,
              );
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        widget.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SpecSectionWidget(
                        title: 'Platform',
                        specs: phoneDetail.allSpecs['Platform']),
                    SpecSectionWidget(
                        title: 'Body', specs: phoneDetail.allSpecs['Body']),
                    SpecSectionWidget(
                        title: 'Display',
                        specs: phoneDetail.allSpecs['Display']),
                    SpecSectionWidget(
                        title: 'Memory', specs: phoneDetail.allSpecs['Memory']),
                    SpecSectionWidget(
                        title: 'Main Camera',
                        specs: phoneDetail.allSpecs['Main Camera']),
                    SpecSectionWidget(
                        title: 'Selfie Camera',
                        specs: phoneDetail.allSpecs['Selfie camera']),
                    SpecSectionWidget(
                        title: 'Sound', specs: phoneDetail.allSpecs['Sound']),
                    SpecSectionWidget(
                        title: 'Comms', specs: phoneDetail.allSpecs['Comms']),
                    SpecSectionWidget(
                        title: 'Features',
                        specs: phoneDetail.allSpecs['Features']),
                    SpecSectionWidget(
                        title: 'Battery',
                        specs: phoneDetail.allSpecs['Battery']),
                    SpecSectionWidget(
                        title: 'Launch', specs: phoneDetail.allSpecs['Launch']),
                    SpecSectionWidget(
                        title: 'Misc', specs: phoneDetail.allSpecs['Misc']),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> fetchPhoneDetail() async {
    try {
      DetailPhone? detail = await PhoneService.fetchPhoneDetail(widget.phoneId);
      if (detail != null) {
        setState(() {
          phoneDetail = detail;
          isLoading = false;
        });
      } else {}
    } catch (e) {}
  }
}
