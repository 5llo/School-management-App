import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Topstudentdata {
  Crud crud;

  Topstudentdata(this.crud);

  getdata() async {
    var response = await crud
        .getData(AppLink.gettopstudents);
    return response.fold((l) => l, (r) => r);
  }


}
