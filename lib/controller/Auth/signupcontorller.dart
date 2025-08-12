// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/data/datasource/remote/auth/signup.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';

abstract class Signupcontorller extends GetxController {
  signup();
  toPageLogin();
}

class SignupcontorllerImp extends Signupcontorller {
final  GlobalKey<FormState> setstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController username;
  late TextEditingController confirmed;

   Statusrequest ? statusrequest=Statusrequest.none;

  SignUpData signUpData = SignUpData(Get.find());

 List group=[
{
 "icon": AppImageassets.fathericonloginpage, 
 "name":"آباء"
}
 ];

MyServices myServices = Get.find();


  List data = [];

  @override
  signup() async {
    var formdata = setstate.currentState;
    if (!formdata!.validate()) return;

    statusrequest = Statusrequest.loading;
    update();
String? fcmtoken = await FirebaseMessaging.instance.getToken();
    var response = await signUpData.postdata(
        username.text, email.text, phone.text, password.text,confirmed.text,fcmtoken??"");
    print("🚀 Response received: $response");

    if (response is Map) {
      if (response.containsKey('status') && response['status'] == 'failure') {
        String errorMessage = "Something went wrong. Try again.";
        
        if (response.containsKey('message')) {
          var message = response['message'];
          if (message is Map && message.containsKey('email')) {
            var emailErrors = message['email'];
            if (emailErrors is List && emailErrors.isNotEmpty) {
              errorMessage = emailErrors.first;
            }
          }
          if (message is Map && message.containsKey('phone')) {
            var emailErrors = message['phone'];
            if (emailErrors is List && emailErrors.isNotEmpty) {
              errorMessage = emailErrors.first;
            }
          }
          if (message is Map && message.containsKey('password')) {
            var emailErrors = message['password'];
            if (emailErrors is List && emailErrors.isNotEmpty) {
              errorMessage = emailErrors.first;
            }
          }
        }

        // ✅ Show dialog with no buttons & dismiss on outside tap
        Get.defaultDialog(
          title: "Warning",
          middleText: errorMessage,
          barrierDismissible: true,
          onWillPop: () async {
            statusrequest = Statusrequest.none;
          update();
            Get.back();
            return true;
          },
        );

        return; // ✅ Stop execution after showing the message
      }

      if (response['status'] == 'success') {
        
// myServices.sharedPreferences.setString("username", response['data']['name']);    parent not have name
myServices.sharedPreferences.setString("email", response['data']['email']);
myServices.sharedPreferences.setString("phone", response['data']['phone']);
myServices.sharedPreferences.setInt("type",2);
myServices.sharedPreferences.setString("step", "2");
myServices.sharedPreferences.setString("token", response['token']);
     
      
        print("✅ Token: ${response['token']}");
      
        Get.offNamed(AppRoute.homeparentpage);
        return;
      }
    }

    // Handle unexpected failure
    Get.defaultDialog(
      title: "Error",
      middleText: "Something went wrong. Try again.",
      barrierDismissible: true,
      onWillPop: () async {
        Get.offAllNamed(AppRoute.signUp);
        return true;
      },
    );

    update();
  }

  @override
  toPageLogin() {
    Get.offNamed(AppRoute.login);
    
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    confirmed = TextEditingController();
    username = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmed.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }


///////this for google: 



 Future<void> signInAndSendTokenToLaravel(int type) async {
    try {
      statusrequest = Statusrequest.loading;
      update();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // المستخدم ألغى تسجيل الدخول
         statusrequest = Statusrequest.none;
         update();
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
         statusrequest = Statusrequest.none;
         update();
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
           statusrequest = Statusrequest.success;
      } else {
        // ظهور رسالة الخطأ من السيرفر
        Get.defaultDialog(
          title: "خطأ",
          middleText: result['message'] ?? "حدث خطأ غير متوقع.",
        );
      }

       statusrequest = Statusrequest.none;
       update();
    } catch (e) {
      print("Google Sign-In Error: $e");
      Get.defaultDialog(title: "خطأ", middleText: "فشل تسجيل الدخول بواسطة جوجل");
    }
  }




}
