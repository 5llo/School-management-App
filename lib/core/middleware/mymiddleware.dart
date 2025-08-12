import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mymiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("step") != null &&
        myServices.sharedPreferences.getString("step") == "2"
       ) {
        if( myServices.sharedPreferences.getInt("type") == 0)
            {return const RouteSettings(name: AppRoute.bushomepage);} 

             if( myServices.sharedPreferences.getInt("type") == 1)
            {return const RouteSettings(name: AppRoute.homescreenteacherpage);} 

             if( myServices.sharedPreferences.getInt("type") == 2)
            {return const RouteSettings(name: AppRoute.visitorhomepage);} 
    }
    if (myServices.sharedPreferences.getString("step") != null &&
        myServices.sharedPreferences.getString("step") == "1") {
      return const RouteSettings(name: AppRoute.login);
      // return const RouteSettings(name: AppRoute.login);
    }
    return null;
  }
}
