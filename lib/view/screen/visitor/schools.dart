import 'package:e_commerce/controller/schoolcontroller.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/view/widget/customappbar.dart';
import 'package:e_commerce/view/widget/visitor/customschoolcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Schools extends StatelessWidget {
  const Schools({super.key});

  @override
  Widget build(BuildContext context) {
    SchoolController controller = Get.put(SchoolController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImageassets.listicon,
              width: 5,
            )),
        title: const Text("المدارس"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
                          CustomAppBar(titleappbar: 'البحث عن مدرسة', onPressedIconSearch: () {  }, onPressedIconfavorite: () {  }, mycontroller: null,),

            
            const SizedBox(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.schools.length,
              itemBuilder: (context, index) {
                return SchoolSquareCard(
                  title: controller.schools[index]['title'],
                  items: controller.schools[index]['items'],
                  color: controller.schools[index]['color'],
                  onTap: () {
                    Get.toNamed(AppRoute.schooldetails);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
