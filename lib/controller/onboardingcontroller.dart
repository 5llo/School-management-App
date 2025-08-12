import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Onboardingcontroller extends GetxController {
  next();
  onPageChanged(int index);
}

class OnboardingcontrollerImp extends Onboardingcontroller {
  late PageController pageController;
  int currentPage = 0;

  MyServices myServices = Get.find();
  @override
  next() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      Get.toNamed(AppRoute.login);
      myServices.sharedPreferences.setString("step", "1" );
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(microseconds: 900), curve: Curves.easeInOut);
    }
  }
 
  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
