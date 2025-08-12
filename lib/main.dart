import 'package:e_commerce/binding.dart';
import 'package:e_commerce/controller/settingscontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  // وضع الكنترولر قبل تشغيل التطبيق
  Get.put(Settingscontroller());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Settingscontroller>(
      builder: (controller) {
        return GetMaterialApp(
          locale: const Locale('ar'),
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',

          // الوضع الفاتح
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 6,
              titleTextStyle: AppTextStyles.cairo16semi,
              backgroundColor: AppColor.color9,
              foregroundColor: Colors.white,
              shadowColor: AppColor.color2,
            ),
            fontFamily: "Cairo",
            scaffoldBackgroundColor:  Colors.white
,
          ),

          // الوضع الداكن
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: "Cairo",
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              elevation: 6,
              titleTextStyle: AppTextStyles.cairo16semi,
              backgroundColor: Colors.black87,
              foregroundColor: Color.fromARGB(255, 102, 100, 100),
              shadowColor: AppColor.color2,
            ),
          ),

          // التبديل بين Light و Dark حسب الكنترولر
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // builder: (context, child) {
          //   return Stack(
          //     children: [
          //       Image.asset(
          //         AppImageassets.registerscreen,
          //         fit: BoxFit.cover,
          //         width: double.infinity,
          //         height: double.infinity,
          //       ),
          //       child ?? const SizedBox(),
          //     ],
          //   );
          // },

          getPages: routes,
          initialBinding: Mybinding(),
        );
      },
    );
  }
}
