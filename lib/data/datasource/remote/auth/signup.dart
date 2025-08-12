import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class SignUpData {
   Crud crud;

   SignUpData(this.crud);

   postdata(String username,String email,String phone,String password,String confirmed,String fcmtoken)async{
     var response = await crud.postData(AppLink.signup, {
      "username": username,
      "email":email,
      "phone":phone,
      "password":password,
      "password_confirmation":confirmed,
      "fcmtoken":fcmtoken,
     });
      return  response.fold((l)=>l, (r)=>r);
   }
}