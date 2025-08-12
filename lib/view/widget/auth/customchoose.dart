import 'package:e_commerce/controller/Auth/logincontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomChoose extends GetView<LogincontrollerImp> {

  final String imagepath;
  final String label;
  final int type;
  final void Function() onTap;
  final int index;
  const CustomChoose({super.key, required this.imagepath, required this.label, required this.type, required this.onTap, required this.index});

  @override
  Widget build(BuildContext context) {
    
         return Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                width:controller.type==index?100: 90,
                height:controller.type==index?100: 90,
                decoration: BoxDecoration(
                color:controller.type==index?const Color(0xffF8F4F8):null,
                  // border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(imagepath, height: 50),
              ),
            ),
            const SizedBox(height: 5),
            Text(label,style:controller.type==index? AppTextStyles.cairo14Bold.copyWith(color: AppColor.color9):AppTextStyles.cairo14,),
          ],
             );
       
    
  }
}





