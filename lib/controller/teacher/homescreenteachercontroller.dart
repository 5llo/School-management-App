// ignore_for_file: avoid_renaming_method_parameters

import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/topstudentdata.dart';
import 'package:e_commerce/data/model/studentsmodel.dart';
import 'package:e_commerce/view/screen/teacher/hometeacherpage.dart';
import 'package:e_commerce/view/screen/teacher/profileteacher.dart';
import 'package:e_commerce/view/screen/teacher/studentspage.dart';
import 'package:e_commerce/view/screen/teacher/weekschedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Homescreenteachercontroller extends GetxController {
  changePage(int currentpage);
}

class HomescreenteachercontrollerImp extends Homescreenteachercontroller {
  int currentpage = 0;
  List<Widget> listPage = [
    Hometeacherpage(),
    Weekschedule(),
    StudentPage(),
    Profileteacher(),
  ];

  List titlebutomapbarlist = [
    {"title": "الرئيسية", "icon": AppImageassets.homeicon},
    {"title": "جدولي", "icon": AppImageassets.tableicon},
    {
      "title": "طلابي",
      "icon": AppImageassets.studentsicon,
    },
    {"title": "ملفي", "icon": AppImageassets.personoutlined},
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }

  Topstudentdata topstudentdata = Topstudentdata(Get.find());
  late Statusrequest statusrequest;
  List<StudentModel> students = [];

  getData() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await topstudentdata.getdata();
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'] == null) {
        statusrequest = Statusrequest.none;
      } else {
        students.clear();

        final data = response['data'];
        students.addAll((data as List)
            .map((e) => StudentModel.fromJson(e))
            .cast<StudentModel>());
        print("✅ Students loaded: ${students.length}");
      }
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
