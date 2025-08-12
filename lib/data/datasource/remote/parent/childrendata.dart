import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Childrendata {
  Crud crud;

  Childrendata(this.crud);

  getdata() async {
    var response = await crud
        .getData(AppLink.getchildrenforparents);
    return response.fold((l) => l, (r) => r);
  }
}