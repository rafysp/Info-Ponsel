import 'package:flutter/material.dart';
import 'package:info_ponsel/widgets/ponsel_terbaru/ponsel_terbaru_model.dart';

class PonselTerbaruCard extends StatelessWidget {
  const PonselTerbaruCard({
    Key? key,
    this.width = 140,
    this.aspectRation = 1.02,
    this.ponselTerbaruModel, // PhoneModel menjadi opsional
  }) : super(key: key);

  final double width, aspectRation;
  final PonselTerbaruModel? ponselTerbaruModel; // PhoneModel ditandai sebagai nullable

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Implement onTap behavior here if needed
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
                        ponselTerbaruModel!.imageUrl,
                        fit: BoxFit.fill,
                      )
                    : Placeholder(), // Placeholder jika imageUrl null
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              ponselTerbaruModel?.brandName ??
                  '', // Menampilkan kosong jika brandName null
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ponselTerbaruModel?.phoneName ??
                  '', // Menampilkan kosong jika phoneName null
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
