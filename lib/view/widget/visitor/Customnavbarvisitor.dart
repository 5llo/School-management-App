import 'package:e_commerce/controller/homescreenvisitorcontroller.dart';
import 'package:e_commerce/view/widget/bus/custombuttomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customnavbarvisitor extends StatelessWidget {
  const Customnavbarvisitor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenVisitorcontrollerImp>(
      builder: (controller) {
        return BottomAppBar(
          color: Colors.white,
          elevation: 18,
          shadowColor: Colors.grey,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: List.generate(controller.listPage.length, (i) {
              return Expanded(
                child: Custombuttomappbar(
                  textbutton: controller.titlebutomapbarlist[i]["title"],
                  icondata: controller.titlebutomapbarlist[i]["icon"],
                  onPressed: () {
                    controller.changePage(i);
                  },
                  active: controller.currentpage == i,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
