// lib/view/screens/splash_screen.dart

import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // مهم للتأخير
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; // علشان التنقل

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التأخير 3 ثواني ثم الانتقال
    Future.delayed(const Duration(seconds: 4), () {
      Get.offNamed(AppRoute.onBoarding); // غيّر "/second" لاسم صفحتك الحقيقية
    });

    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 140,),
          Center(
            child:  Lottie.asset(
              AppImageassets.schoollottie,
             
             repeat: false,
              width: 400,
              height: 400,
            ),
          ),
          Center(
            child:  Lottie.asset(
              AppImageassets.loading
              ,
              width: 200,
              height: 200,
            ),
          ),
          const Center(
            child:  Text(
              "School App",style: AppTextStyles.cairo26Bold,
            )
          ),
        ],
      ),
    );
  }
}
