import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/parent/studentmenucontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Homeparentpage extends StatelessWidget {
  const Homeparentpage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Studentmenucontroller());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "أبنائي",
          ),
          leading: const Icon(Icons.menu),
        ),
        body: GetBuilder<Studentmenucontroller>(builder: (controller) {
          return Handlingdataview(
              statusrequest: controller.statusrequest,
              widget: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.childrens.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoute.childmenu,arguments:{

                                "children_id": controller.childrens[index].childrenId,
                                "children_name": controller.childrens[index].childrenName,
                                "calss": controller.childrens[index].className,
                                "division": controller.childrens[index].schoolClassDivision,
                                "parent_id": controller.childrens[index].parentId,
                                "parent_name": controller.childrens[index].parentName,
                                "teacher_id": controller.childrens[index].teacherId,
                                "teacher_name": controller.childrens[index].teacherName,
                                "driver_id" : controller.childrens[index].driverId,
                                "driver_name" : controller.childrens[index].driverName,
                                "schoolLat" : controller.childrens[index].schoolLat,
                                "schoolLong" : controller.childrens[index].schoolLong,
                                
                                });
                            },
                            child: Card(
                              color: AppColor.textfield,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                controller.childrens[index]
                                                        .imageUrl ??
                                                    '',
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                  "${controller.childrens[index].childrenName}",
                                                  style: AppTextStyles
                                                      .cairo16semi
                                                      .copyWith(
                                                          color:
                                                              AppColor.color9)),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(Icons.square_rounded,
                                                color: Colors.green, size: 14),
                                            SizedBox(width: 6),
                                            Text("في الدوام الآن",
                                                style: AppTextStyles.cairo14),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        const Icon(Icons.school_outlined,
                                            size: 20, color: AppColor.color9),
                                        const SizedBox(width: 6),
                                        Text(
                                            "${controller.childrens[index].schoolClassDivision}",
                                            style: AppTextStyles.cairo14),
                                        const SizedBox(width: 24),
                                        const Icon(Icons.view_module_outlined,
                                            size: 20, color: AppColor.color9),
                                        Text(
                                            "${controller.childrens[index].className}",
                                            style: AppTextStyles.cairo14),
                                      ],
                                    ),
                                    const SizedBox(height: 24),

                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppImageassets.bookicontwo),
                                        const SizedBox(width: 6),
                                        Text(
                                            "${controller.childrens[index].schoolName}",
                                            style: AppTextStyles.cairo14),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),

                                    const Divider(height: 20),

                                    // ✅ DETAILS TEXT CENTERED
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "انقر لعرض التفاصيل",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
