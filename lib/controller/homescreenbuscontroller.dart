// ignore_for_file: avoid_renaming_method_parameters

import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/view/screen/busdriver/mappage.dart';
import 'package:e_commerce/view/screen/busdriver/profilepage.dart';
import 'package:e_commerce/view/screen/busdriver/studentspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomescreenBuscontroller extends GetxController {
  changePage(int currentpage);
}

class HomescreenBuscontrollerImp extends HomescreenBuscontroller {
  int currentpage = 0;
  List<Widget> listPage = [

    const Studentspage(),
    const MapPage(),
      ProfilePage(),
 
  ];

  List titlebutomapbarlist = [
  {"title": "الطلاب", "icon": AppImageassets.studentsicon},
  {"title": "الخريطة", "icon": AppImageassets.map2}, // بدل أيقونة البيت بأيقونة الخريطة
  {"title": "ملفي", "icon": AppImageassets.personoutlined},
];


  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
