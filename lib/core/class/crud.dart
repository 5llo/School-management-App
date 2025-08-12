import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/checkinternet.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Crud {

  MyServices myServices=Get.find();
  Future<Either<Statusrequest, Map>> postData(String linkurl, var data) async { //the data type was List,i make it var,because when i update all students grades use list of list
    try {
      if (await checkInternet()) {
        print("📢 Sending Request to: $linkurl");
        print("📩 Data: $data");

 Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  String? token = myServices.sharedPreferences.getString("token");
  if (token != null) {
    headers["Authorization"] = "Bearer $token";
  }

   var response = await http.post(
    Uri.parse(linkurl),
    headers: headers,
    body: jsonEncode(data),
  );



        print("📥 Response Status: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 422) {
          return Right(jsonDecode(response.body)); // Handle validation errors
        } else if (response.statusCode == 404) {
          return const Left(Statusrequest.serverfailure);
        } else {
          return const Left(Statusrequest.serverException);
        }
      } else {
        return const Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print("❌ Error: $e");
      return const Left(Statusrequest.serverException);
    }
  }

/////////////get data type/////////

 Future<Either<Statusrequest, Map>> getData(String linkurl) async {
    try {
      if (await checkInternet()) {
        print("📢 Sending Request to: $linkurl");
      //  print("📩 Data: $data");

 Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  String? token = myServices.sharedPreferences.getString("token");
  if (token != null) {
    headers["Authorization"] = "Bearer $token";
  }

   var response = await http.get(
    Uri.parse(linkurl),
    headers: headers,
  //  body: jsonEncode(data),
  );



        print("📥 Response Status: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 422) {
          return Right(jsonDecode(response.body)); // Handle validation errors
        } else if (response.statusCode == 404) {
          return const Left(Statusrequest.serverfailure);
        } else {
          return const Left(Statusrequest.serverException);
        }
      } else {
        return const Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print("❌ Error: $e");
      return const Left(Statusrequest.serverException);
    }
  }




}
