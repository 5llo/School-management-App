// ignore: file_names
import 'package:e_commerce/controller/onboardingcontroller.dart';
import 'package:e_commerce/view/widget/onboarding/custombutton.dart';
import 'package:e_commerce/view/widget/onboarding/customslider.dart';
import 'package:e_commerce/view/widget/onboarding/dotscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
  OnboardingcontrollerImp controller=  Get.put(OnboardingcontrollerImp());
    return Scaffold(

      body:  SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Content section without Expanded
              const Expanded(
               // flex: 6,
                child: CustomsliderOnBoarding()
              ) ,
          
              // Circles indicators
              const Dotscontroller(),
          
              // Continue button
          CustombuttonOnBoarding(title: 'متابعة', onPressed: (){controller.next();},)
            ],
          ),
        ),
      ),
    );
  }
}
