import 'dart:io';

import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HomeworkData {
  Crud crud;
  HomeworkData(this.crud);
    MyServices myServices = Get.find();

  getData() async {
    var response = await crud.getData(AppLink.gethomeworks); // رابط الوظائف
    return response.fold((l) => l, (r) => r);
  }
  gethomeworkForParent(String childrenId) async {
    var response = await crud.postData(AppLink.gethomeworkForParent,{"student_id":childrenId}); // رابط الوظائف
    return response.fold((l) => l, (r) => r);
  }


Future sendData(File file, String description) async {
  final token = myServices.sharedPreferences.getString("token");

  var uri = Uri.parse(AppLink.uploadhomework);

  var request = http.MultipartRequest("POST", uri);
  request.headers['Authorization'] = 'Bearer $token'; // أضف التوكن
  request.headers['Accept'] = 'application/json';

  request.fields['description'] = description;

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: basename(file.path),
    ),
  );

  try {
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    print("📤 Response Body: ${responseData.body}");

    if (response.statusCode == 200) {
      return {
        "status": "success",
        "data": responseData.body
      };
    } else {
      return {
        "status": "failure",
        "message": "فشل في رفع الملف"
      };
    }
  } catch (e) {
    return {
      "status": "failure",
      "message": e.toString()
    };
  }
}

}
