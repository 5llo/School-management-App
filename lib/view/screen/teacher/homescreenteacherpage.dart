import 'package:e_commerce/controller/teacher/homescreenteachercontroller.dart';
import 'package:e_commerce/view/widget/teacher/custombuttonnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreenteacherpage extends StatelessWidget {
  const Homescreenteacherpage({super.key});


  @override
  Widget build(BuildContext context) {
    
    Get.put(HomescreenteachercontrollerImp());
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); 
      },
      child: GetBuilder<HomescreenteachercontrollerImp>(
          builder: (basiccontroller) => Scaffold(
             
            
              bottomNavigationBar: const Custombuttonnavbar(),
              body: basiccontroller.listPage.elementAt(basiccontroller.currentpage))),
    );
  }
}
