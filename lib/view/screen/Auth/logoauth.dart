import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';

class Logoauth extends StatelessWidget {
  const Logoauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImageassets.logo,height: 120,);
  }
}