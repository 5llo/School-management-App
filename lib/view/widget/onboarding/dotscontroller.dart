import 'package:e_commerce/controller/onboardingcontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dotscontroller extends StatelessWidget {
  const Dotscontroller({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingcontrollerImp>(builder: (controller)=>Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    onBoardingList.length,
                    (index) => AnimatedContainer(
                      margin: const EdgeInsets.only(right: 10),
                      duration: const Duration(milliseconds: 300),
                      width: controller.currentPage ==index ?14 :7 ,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColor.color9,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}