import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Resultdata {
  Crud crud;

  Resultdata(this.crud);

  getdata(String childrenId) async {
    var response = await crud
        .postData(AppLink.getresult,{"student_id" : childrenId});
    return response.fold((l) => l, (r) => r);
  }
  getposts(String childrenId) async {
    var response = await crud
        .postData(AppLink.getSchoolsClassesDivisionPost,{"student_id" : childrenId});
    return response.fold((l) => l, (r) => r);
  }
}