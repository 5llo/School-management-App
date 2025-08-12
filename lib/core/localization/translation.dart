import 'package:get/get.dart';

class Mytranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {  "1" : ": اختر اللغة",
                  "2": "اهلا بعودتك"
        },
        "en": {  "1" : "Choose laguage :",
                "2" : "Welcome Back"  ,
                "3" : "Sign in your email and password or continue with social media "  ,
                 },
      };
}
