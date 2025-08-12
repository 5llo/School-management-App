// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/controller/homescreenbuscontroller.dart';
import 'package:e_commerce/view/widget/bus/custombuttomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class custombuttomappbarhome extends StatelessWidget {
  const custombuttomappbarhome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenBuscontrollerImp>(
      builder: (controller) {
        return BottomAppBar(
          color: Colors.white,
          elevation: 18,
          shadowColor: Colors.grey,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(controller.listPage.length , ((i) {
            
             
                return 
                  
                     Custombuttomappbar(
                        textbutton: controller.titlebutomapbarlist[i]["title"],
                        icondata:controller.titlebutomapbarlist[i]["icon"] ,
                        onPressed: () {
                        
                          controller.changePage(i);
                        },
                        active: controller.currentpage == i ? true : false);
              })),
            ],
          ),
        );
      }
    );
  }
}
