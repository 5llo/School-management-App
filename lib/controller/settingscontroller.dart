import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Settingscontroller extends GetxController {
  final MyServices myServices = Get.find();

  /// اللغة الحالية
  String selectedLanguage = 'العربية';

  /// تغيير اللغة
  void changeLanguage(String lang) {
    selectedLanguage = lang;
    update();
  }

  /// الوضع الليلي (true = مفعّل)
  bool isDarkMode = false;

  /// مفتاح آخر للإعدادات (غير محدد الاستخدام هنا)
  bool value3 = true;

  /// تبديل الوضع الليلي / الفاتح
  void changeswitchone() {
    isDarkMode = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  /// تبديل قيمة إعداد آخر
  void changeswitchthree() {
    value3 = !value3;
    update();
  }

  /// تسجيل الخروج مباشرة
void logout() async {
  GoogleSignIn googleSignIn = GoogleSignIn();

  // تحقق إذا فيه مستخدم Google مسجّل
  if (await googleSignIn.isSignedIn()) {
    await googleSignIn.signOut();
  }

  // مسح البيانات المحلية
  myServices.sharedPreferences.clear();

  // الرجوع إلى صفحة تسجيل الدخول
  Get.offAllNamed(AppRoute.login);
}


  /// نافذة تأكيد تسجيل الخروج
  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber),
            SizedBox(width: 10),
            Text(
              "تأكيد تسجيل الخروج",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          "هل أنت متأكد أنك تريد تسجيل الخروج؟",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("تسجيل الخروج"),
          ),
        ],
      ),
    );
  }

  /// getter للحالة الحالية للوضع الليلي (للاستخدام في الواجهات)
  bool get value1 => isDarkMode;
}
