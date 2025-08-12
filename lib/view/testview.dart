import 'package:e_commerce/controller/testcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Testview extends StatelessWidget {
  const Testview({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Testcontroller());
    return Scaffold(
      appBar: AppBar(
    
        foregroundColor: Colors.white,
        title: const Text("test"),
      ),
      body: 
      Column(
        children: [
          const Center(child: Text("hello"),),
        SvgPicture.asset(AppImageassets.google)
        ],
      )
      // GetBuilder<Testcontroller>(builder: (controller) {
      //  return Handlingdataview(statusrequest: controller.statusrequest, widget:ListView.builder(
      //      itemCount: controller.data.length,
      //      itemBuilder: (context, index) {
      //        return Text("${controller.data}");
      //      }) );
      //   }
      // ),
    );
  }
}








//  if (controller.statusrequest == Statusrequest.loading) {
//           return const Center(
//             child: Text("Loading..."),
//           );
//         } else if (controller.statusrequest == Statusrequest.offlinefailure) {
//           return const Center(
//             child: Text("ofline failure..."),
//           );
//         } else if (controller.statusrequest == Statusrequest.serverfailure) {
//           return const Center(
//             child: Text("server failure..."),
//           );
//         }else if (controller.statusrequest == Statusrequest.failure) {
//           return const Center(
//             child: Text("No data..."),
//           );
//         } else {
//           return ListView.builder(
//               itemCount: controller.data.length,
//               itemBuilder: (context, index) {
//                 return Text("${controller.data}");
//               })