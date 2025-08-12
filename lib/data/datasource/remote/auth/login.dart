import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postdata(String email, String password,int type,String fcmtoken)async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
      "type":type,
      "fcmtoken":fcmtoken
    });
    return response.fold((l) => l, (r) => r);
  }
}
