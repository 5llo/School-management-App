import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';

class PhotosTab extends StatelessWidget {
  final List<String> imageUrls = [
AppImageassets.schoolone,
AppImageassets.busone ,
AppImageassets.classroom,
AppImageassets.library,
AppImageassets.unversity,
  ];

   PhotosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(url, width: 400, height: 200, fit: BoxFit.fill),
        );
      }).toList(),
    );
  }
}
