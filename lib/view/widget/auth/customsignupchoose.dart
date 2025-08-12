import 'package:e_commerce/controller/Auth/signupcontorller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Customsignupchoose extends GetView<SignupcontorllerImp> {

  final String imagepath;
  final String label;
  final int type;
  final void Function() onTap;
  final int index;
  const Customsignupchoose({super.key, required this.imagepath, required this.label, required this.type, required this.onTap, required this.index});

  @override
  Widget build(BuildContext context) {
    
         return Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                width:100,
                height:100,
                decoration: BoxDecoration(
                color:const Color(0xffF8F4F8),
                  // border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(imagepath, height: 50),
              ),
            ),
            const SizedBox(height: 5),
            Text(label,style: AppTextStyles.cairo14Bold.copyWith(color: AppColor.color9)),
          ],
             );
       
    
  }
}





