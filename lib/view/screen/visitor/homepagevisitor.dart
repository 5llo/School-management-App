import 'package:e_commerce/controller/homescreenvisitorcontroller.dart';
import 'package:e_commerce/view/widget/visitor/Customnavbarvisitor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepagevisitor extends StatelessWidget {
  const Homepagevisitor({super.key});


  @override
  Widget build(BuildContext context) {
    
    Get.put(HomescreenVisitorcontrollerImp());
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); 
      },
      child: GetBuilder<HomescreenVisitorcontrollerImp>(
          builder: (controller) => Scaffold(
             
            
              bottomNavigationBar: const Customnavbarvisitor(),
              body: controller.listPage.elementAt(controller.currentpage))),
    );
  }
}
