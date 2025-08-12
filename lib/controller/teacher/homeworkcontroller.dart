import 'dart:io';
import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/homeworkdata.dart';
import 'package:e_commerce/data/model/homeworkmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkController extends GetxController {
  HomeworkData homeworkdata = HomeworkData(Get.find());

  late Statusrequest statusRequest;
  List<HomeworkModel> homeworks = [];

  File? selectedFile;
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    statusRequest = Statusrequest.loading;
    update();

    var response = await homeworkdata.getData();

    statusRequest = handlingData(response);
    if (statusRequest == Statusrequest.success) {
      List listdata = response['data'];
      homeworks = listdata.map((e) => HomeworkModel.fromJson(e)).toList();
    }

    update();
  }

  Future<void> uploadHomework(File file, String description) async {
    statusRequest = Statusrequest.loading;
    update();

    var response = await homeworkdata.sendData(file, description);
    statusRequest = handlingData(response);

    if (statusRequest == Statusrequest.success) {
      Get.back();
      getData();
    } else {
     Get.snackbar(
  "خطأ", 
  "فشل في رفع الوظيفة",
  backgroundColor: Colors.white,
  colorText: Colors.black,
  borderRadius: 12,
  margin: const EdgeInsets.all(16),
  snackPosition: SnackPosition.BOTTOM,
  boxShadows: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ],
  icon: const Icon(Icons.error, color: Colors.red),
);

    }

    update();
  }
}
