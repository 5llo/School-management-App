import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Custombuttonprofile extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const Custombuttonprofile(
      {super.key, required this.icon, required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      
     // margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        
        leading: SvgPicture.asset(icon),
        title: Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: SvgPicture.asset(AppImageassets.backprofileicon),
        onTap:onTap,
      ),
    );
  }
}
