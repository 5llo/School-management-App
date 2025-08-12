// google_signin_service.dart

import 'package:e_commerce/linkapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSignInService {
  static Future<void> signInAndSendTokenToLaravel(int type) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // المستخدم ألغى تسجيل الدخول
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          print("######the token id of google: ");
          print(googleAuth.idToken);
      // تحقق من وجود الـ idToken
      if (googleAuth.idToken == null) {
        Get.defaultDialog(
          title: "خطأ",
          middleText: "لم يتم الحصول على توكن جوجل. الرجاء المحاولة مرة أخرى.",
        );
        return;
      }

      final String idToken = googleAuth.idToken!;
      final String accessToken = googleAuth.accessToken ?? "";

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      // تسجيل الدخول إلى Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      // الحصول على FCM Token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      String url = AppLink.server;
 print("this will send to backedn ,token google is  :");
 print(idToken);
 print("this will send to backedn type:");
 print(type);
      // إرسال البيانات إلى Laravel كـ JSON
      final response = await http.post(
        Uri.parse("$url/login/google"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token": idToken,
          "type": type.toString(),
          "fcmtoken": fcmToken ?? "",
        }),
      );

      // فك ترميز الاستجابة
      final Map result = json.decode(response.body);
      print("✅ Laravel Google login response: $result");

      if (result["status"] == "success") {
        // حفظ بيانات المستخدم في SharedPreferences
        MyServices myServices = Get.find();

        myServices.sharedPreferences.setString("username", result['data']['name']);
        myServices.sharedPreferences.setString("email", result['data']['email']);
        myServices.sharedPreferences.setString("token", result['token']);
        myServices.sharedPreferences.setInt("type", type);
        myServices.sharedPreferences.setString("step", "2");

        // التنقل حسب نوع المستخدم
        if (type == 0) {
          Get.offNamed(AppRoute.bushomepage);
        } else if (type == 1) {
          Get.offNamed(AppRoute.homescreenteacherpage);
        } else if (type == 2) {
          Get.offNamed(AppRoute.visitorhomepage);
        }
      } else {
        // ظهور رسالة الخطأ من السيرفر
        Get.defaultDialog(
          title: "خطأ",
          middleText: result['message'] ?? "حدث خطأ غير متوقع.",
        );
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      Get.defaultDialog(title: "خطأ", middleText: "فشل تسجيل الدخول بواسطة جوجل");
    }
  }
}
