// ignore_for_file: avoid_print

import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/data/datasource/remote/auth/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Logincontroller extends GetxController{
  login();
  toPageSignUp();
}

class LogincontrollerImp extends Logincontroller{

 final GlobalKey<FormState> formstate=GlobalKey<FormState>();


late TextEditingController email;
late TextEditingController password;
 int type =0;


 settype(int index){
  type = index;
  update();
 }
 List group=[
{
 "icon": AppImageassets.busiconloginpage, 
 "name":"سائقين"
},
{
 "icon": AppImageassets.teachericonloginpage, 
 "name":"معلمين"
},
{
 "icon": AppImageassets.fathericonloginpage, 
 "name":"آباء"
}
 ];

MyServices myServices = Get.find();
   Statusrequest ? statusrequest=Statusrequest.none;

     LoginData loginData = LoginData(Get.find());

  List data = [];

@override
login() async {
  var formdata = formstate.currentState;
  if (!formdata!.validate()) return;

  statusrequest = Statusrequest.loading;
  update();
String? fcmtoken = await FirebaseMessaging.instance.getToken();
  var response = await loginData.postdata(email.text, password.text,type,fcmtoken??"");
  print("🚀 Response received: $response");

  if (response is Map) {
    if (response.containsKey('status') && response['status'] == 'failure') {
      Get.defaultDialog(
        title: "Warning",
        middleText: response['message'],
        barrierDismissible: true, // Tap outside to dismiss
        onWillPop: () async {
          // If user taps outside, close and go to login
          statusrequest = Statusrequest.none;
          update();
          Get.offAllNamed(AppRoute.login);
          return true;
        },
      );
    } else if (response['status'] == 'success') {
      print("✅ Token: ${response['token']}");


//  "schools_classes_division_id": 1,
//     "school_id": 1,
//     "phone": "0909090909",
//     "gender": "male",
//     "email": "aall@gmail.com",
//     "password": "12121212",
//     "name": "ali ali",

myServices.sharedPreferences.setInt("id", response['data']['id']);
myServices.sharedPreferences.setString("username", response['data']['name']);
myServices.sharedPreferences.setString("email", response['data']['email']);
myServices.sharedPreferences.setString("phone", response['data']['phone']);
myServices.sharedPreferences.setInt("type",type);
myServices.sharedPreferences.setString("step", "2");
myServices.sharedPreferences.setString("token", response['token']);
     if(type ==0)
     { Get.offNamed(AppRoute.bushomepage);}

    if(type ==1)
     { Get.offNamed(AppRoute.homescreenteacherpage);}

      if(type ==2)
     { Get.offNamed(AppRoute.visitorhomepage);}

      statusrequest = Statusrequest.success;
    }
  } else {
    Get.defaultDialog(
      title: "عذرا...",
      middleText: "اسم المستخدم او كلمة المرور غير صحيحة.",
      barrierDismissible: true,
      onWillPop: () async {
        statusrequest = Statusrequest.none;
        update();
        Get.offAllNamed(AppRoute.login);
        return true;
      },
    );
  }

  update();
}

  @override
  toPageSignUp() {
    Get.offNamed(AppRoute.signUp);
 
    // Get.delete<LogincontrollerImp>(); or replace it with lazyput
  }

  @override
  void onInit() {
FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getToken().then((value){
    print( "the ✅ Token-device is : $value");
  
  });


    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {

    email.dispose();
    password.dispose();
    super.dispose();
  }
  
}