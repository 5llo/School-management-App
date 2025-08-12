import 'package:get/get_utils/get_utils.dart';

validInput(String val, int min, int max, String type) {


  
if(val.isEmpty){
  return "لا يمكن ان يكون الحقل فارغ";
}


  if (val.length < min) {
    return "القيمة لا يمكن ان تكون اقل من  $min";
  }
  if (val.length > max) {
    return "القيمة لا يمكن ان تكون اكبر من  $max";
  }

  
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "اسم المستخدم غير صالح";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "البريد غير صالح";
    }
  }
  if (type == "pnone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "الرقم غير صالح";
    }
  }




}
