import 'package:flutter/material.dart';
import 'package:info_ponsel/model/ponsel_terbaru_model.dart';
import 'package:info_ponsel/pages/phone_detail.dart';

class PonselTerbaruCard extends StatelessWidget {
  const PonselTerbaruCard({
    Key? key,
    this.width = 140,
    this.aspectRation = 1.02,
    this.ponselTerbaruModel,
  }) : super(key: key);

  final double width, aspectRation;
  final PonselTerbaruModel? ponselTerbaruModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman PhoneDetailPage saat card ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneDetailPage(
              phoneId: ponselTerbaruModel?.id ?? '',
              imageUrl: ponselTerbaruModel?.imageUrl ?? '',
              phoneName: ponselTerbaruModel?.phoneName ?? '',
              description: ponselTerbaruModel?.description ?? '',
              brandName: ponselTerbaruModel?.brandName ?? '',
            ),
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ponselTerbaruModel?.imageUrl != null
                    ? Image.network(
                        ponselTerbaruModel!.imageUrl!,
                        fit: BoxFit.fill,
                      )
                    : Placeholder(),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              ponselTerbaruModel?.brandName ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ponselTerbaruModel?.phoneName ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
