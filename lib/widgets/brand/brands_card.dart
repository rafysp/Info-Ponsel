import 'package:flutter/material.dart';

class BrandsCard extends StatelessWidget {
  const BrandsCard({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
