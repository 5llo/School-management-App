// ignore_for_file: avoid_renaming_method_parameters

import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/screen/parent/homeparentpage.dart';
import 'package:e_commerce/view/screen/parent/profileparentpage.dart';
import 'package:e_commerce/view/screen/visitor/posts.dart';
import 'package:e_commerce/view/screen/visitor/schools.dart';
import 'package:e_commerce/view/widget/onboarding/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

abstract class HomescreenVisitorcontroller extends GetxController {
  changePage(int currentpage);
}

class HomescreenVisitorcontrollerImp extends HomescreenVisitorcontroller {
  
  int currentpage = 1;


 HomescreenVisitorcontrollerImp() {
    currentpage = myServices.sharedPreferences.getInt("type") != 2 ? 1: 0;
  }



  MyServices myServices = Get.find();
List<Widget> get listPage => [
    if (myServices.sharedPreferences.getInt("type") != 2) Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Lottie.asset(AppImageassets.loginfrist,
                    width: 150, height: 150, repeat: false),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "صفحة اطفالي !",
                  style: AppTextStyles.cairo24,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "قم بتسجيل الدخول لمتابعة اطفالك !",
                  style: AppTextStyles.cairo16semi,
                ),
                const SizedBox(
                  height: 64,
                ),
                // Custombuttomloginregister(onPressed: (){Get.offAllNamed(AppRoute.login);}, title: "الذهاب لصفحة التسجيل")
                CustombuttonOnBoarding(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.login);
                  },
                  title: 'سجل الان',
                ),
              ],
            ),
          ) else const Homeparentpage(),
     Posts(childrenId: '4',),
    const Schools(),
   
 myServices.sharedPreferences.getInt("type") != 2?  Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Lottie.asset(AppImageassets.loginfrist,
              width: 150, height: 150, repeat: false),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "صفحة ملفي الشخصي !",
            style: AppTextStyles.cairo24,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "قم بتسجيل الدخول لمتابعة ملفك بسهولة !",
            style: AppTextStyles.cairo16semi,
          ),
          const SizedBox(
            height: 64,
          ),
          // Custombuttomloginregister(onPressed: (){Get.offAllNamed(AppRoute.login);}, title: "الذهاب لصفحة التسجيل")
          CustombuttonOnBoarding(
            onPressed: () {
              Get.offAllNamed(AppRoute.login);
            },
            title: 'سجل الان',
          ),
        ],
      ),
    ):const Profileparentpage(),
  ];

  List titlebutomapbarlist = [
    {"title": "الرئيسية", "icon": AppImageassets.homeoutlined2},
    {"title": "المنشورات ", "icon": AppImageassets.newpost},
    {"title": "المدارس", "icon": AppImageassets.booksicon},
    {"title": "ملفي", "icon": AppImageassets.personoutlined},
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
