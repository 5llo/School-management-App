import 'package:e_commerce/controller/teacher/homescreenteachercontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Customcardhomestudents extends GetView<HomescreenteachercontrollerImp> {
  final String title;
  const Customcardhomestudents({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomescreenteachercontrollerImp>(
      builder: (controller) {
        return Card(
                      child: Container(
                      
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                    
              gradient:  const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                AppColor.color9,
                  AppColor.color7
                ],
              ),
                        ),
                        padding: const EdgeInsets.only(top: 4.0,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage(AppImageassets.profileimage),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                             title,
                              style: AppTextStyles.cairo14Bold
                                  .copyWith(color: AppColor.white),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                      AppImageassets.arrowfordetails)),
                            )
                          ],
                        ),
                      ),
                    );
      }
    )
              ;
  }
}