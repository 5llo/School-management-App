import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Studentdata {
  Crud crud;

  Studentdata(this.crud);

  getdata(String material, int index,String date) async {
    var response = await crud
        .postData(AppLink.getstudentandoralgrade, {"material": material,"index":index-1,"date":date});
    return response.fold((l) => l, (r) => r);
  }

  senddatastateandoral(Map<String, dynamic> data) async {
    var response = await crud.postData(AppLink.sendstateandoralgrade, data);
    return response.fold((l) => l, (r) => r);
  }
}
