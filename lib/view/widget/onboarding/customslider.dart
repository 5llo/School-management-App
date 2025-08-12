import 'package:e_commerce/controller/onboardingcontroller.dart';
import 'package:e_commerce/data/datasource/static/static.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomsliderOnBoarding extends GetView<OnboardingcontrollerImp> {
  const CustomsliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {controller.onPageChanged(value);} ,
                itemCount: onBoardingList.length,
                itemBuilder: (context, i) => Column(
             //     mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
          
                    SvgPicture.asset(
                      onBoardingList[i].image!,
                      height: 250,fit: BoxFit.fill, // Control image size if it's too big
                    ),
                    const SizedBox(height: 80), // Reduced from 40

                    Text(
                      onBoardingList[i].title!,
                      style: AppTextStyles.cairo20Bold,
                    ),
   const SizedBox(height: 40), // Reduced from 40

                Text(
                        onBoardingList[i].body!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cairo16,
                      ),
                 
                  ],
                ),
              );
  }
}