import 'dart:ui';

import 'package:e_commerce/core/services/services.dart';
import 'package:get/get.dart';

class LocalController extends GetxController{

  Locale? language;

  MyServices myServices = Get.find();
  changeLang(String languageCode){
    Locale locale = Locale(languageCode);
    myServices.sharedPreferences.setString("lang", languageCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
       String?  sharedprefLang =  myServices.sharedPreferences.getString("lang");
    if(sharedprefLang =="ar"){
      language = const Locale("ar");}
      else if(sharedprefLang =="en"){
        language = const Locale("en");}
        else{
          language = Locale(Get.deviceLocale!.languageCode); 

        }
      
    
    super.onInit();
  }
  
}