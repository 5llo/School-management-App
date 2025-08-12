import 'package:e_commerce/controller/homescreenbuscontroller.dart';
import 'package:e_commerce/view/widget/bus/custombuttonnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Busmappage extends StatelessWidget {
  const Busmappage({super.key});


  @override
  Widget build(BuildContext context) {
    
    Get.put(HomescreenBuscontrollerImp());
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); 
      },
      child: GetBuilder<HomescreenBuscontrollerImp>(
          builder: (controller) => Scaffold(
             
            
              bottomNavigationBar: const custombuttomappbarhome(),
              body: controller.listPage.elementAt(controller.currentpage))),
    );
  }
}
