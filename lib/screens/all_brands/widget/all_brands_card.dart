import 'package:flutter/material.dart';
import 'package:info_ponsel/screens/all_brands/all_brands_page.dart';

class AllBrandsCard extends StatelessWidget {
  final String name;

  const AllBrandsCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            brandNameToImagePath(name),
            height: 150,
            width: 150,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                child: Icon(
                  Icons.image_not_supported,
                  size: 48,
                ),
              );
            },
          ),
          SizedBox(height: 8.0),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
