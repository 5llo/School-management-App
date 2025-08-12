import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class StudentsDetailsData {
  Crud crud;

  StudentsDetailsData(this.crud);

  getdata() async {
    var response = await crud
        .getData(AppLink.getstudentswithdetails);
    return response.fold((l) => l, (r) => r);
  }

  senddatastateandoral(Map<String, dynamic> data) async {
    var response = await crud.postData(AppLink.sendstateandoralgrade, data);
    return response.fold((l) => l, (r) => r);
  }




  
  sendstudentsgrades(Map<String, dynamic> data) async {
    var response = await crud.postData(AppLink.updateStudentGrades, data);
    return response.fold((l) => l, (r) => r);
  }
  
  sendallgradeforallstudents(List<Map<String, dynamic>> data) async {
    var response = await crud.postData(AppLink.sendallgradeforallstudents, data);
    return response.fold((l) => l, (r) => r);
  }



}
