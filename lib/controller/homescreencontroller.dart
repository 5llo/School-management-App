// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Homescreencontroller extends GetxController {
  changePage(int currentpage);
}

class HomescreencontrollerImp extends Homescreencontroller {
  int currentpage = 0;
  List<Widget> listPage = [
   // const Homepage(),
    const Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: Text("Settings"),
        )
      ],
    ),
    const Column(
      children: [
        Center(
          child: Text("Favourite"),
        )
      ],
    ),
   // const Settings(),
  ];

  List titlebutomapbarlist = [
    {"title": "home", "icon": Icons.home},
    {"title": "note ", "icon": Icons.notifications_active_outlined},
    {"title": "profile", "icon": Icons.person},
    {"title": "settings", "icon": Icons.settings},
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
