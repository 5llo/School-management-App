import 'package:e_commerce/controller/onboardingcontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustombuttonOnBoarding extends GetView<OnboardingcontrollerImp> {
 final void Function()? onPressed;
 final String title;
   const CustombuttonOnBoarding({super.key,this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return     Padding(
              padding: const EdgeInsets.only(bottom: 64 ),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                onPressed: onPressed,
                color: AppColor.color9,
                textColor: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8),
             ),
                child:  Text(title,
              
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
            );
  }
}