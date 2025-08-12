import 'package:e_commerce/controller/teacher/homescreenteachercontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/function/RefreshIndicator.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/screen/teacher/chatpageforteacher.dart';
import 'package:e_commerce/view/screen/teacher/customweekschduale.dart';
import 'package:e_commerce/view/widget/customappbar.dart';
import 'package:e_commerce/view/widget/teacher/customcardhomestudents.dart';
import 'package:e_commerce/view/widget/teacher/reviewcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Hometeacherpage extends StatelessWidget {
  const Hometeacherpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
  HomescreenteachercontrollerImp controller =  Get.put(HomescreenteachercontrollerImp());

    return Scaffold(
     // backgroundColor: Colors.white,
     appBar: AppBar(
 // backgroundColor: Colors.white,
  elevation: 0,
  titleSpacing: 0,
  title: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // أيقونات على اليمين
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImageassets.notificationhometeacherpage, width: 35),
            ),
           IconButton(
  onPressed: () => Get.to(() => const ChatTeacherPage(teacherId: "1",)),
  icon: SvgPicture.asset(AppImageassets.chaticon, width: 35),
),

          ],
        ),

        // أيقونات على اليسار
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImageassets.contesticon, width: 35),
            ),
            IconButton(
              onPressed: () => Get.toNamed(AppRoute.homework),
              icon: SvgPicture.asset(AppImageassets.homeworkicon, width: 35,),
            ),
          ],
        ),
      ],
    ),
  ),
),

      body: MyRefreshWidget(
                onRefresh: () async{await  controller.getData(); },
                child:
      
       GetBuilder<HomescreenteachercontrollerImp>(
        builder: (controller) {
          return Handlingdataview(
            statusrequest: controller.statusrequest,
            widget: RefreshIndicator(
              onRefresh: () async{await controller.getData(); },
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6, left: 6, bottom: 12),
                    child: CustomAppBar(
                      top: "true",
                      titleappbar: 'ابحث عن طالب',
                      onPressedIconSearch: () {},
                      onPressedIconfavorite: () {},
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppImageassets.teacherhomepageimage,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 40, left: 40, top: 50),
                        child: Text(
                          "تذكر دائما : نجاح طلابك يبدأ بالتواصل \nالفعال مع اهاليهم .أبلغهم بأي تقصير لتكون جزءاً من الحل النافع لهم ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 180,
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          onPressed: () {},
                          color: AppColor.textfield,
                          textColor: AppColor.color2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "تواصل الان",
                            style: AppTextStyles.cairo14Bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20, top: 20, bottom: 8),
                    child: Text(
                      "الاكثر تميزا :",
                      style: AppTextStyles.cairo16Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          controller.students.length,
                          (index) => Customcardhomestudents(title: controller.students[index].name!),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20, top: 12, bottom: 10),
                    child: Text(
                      "جدول اليوم :",
                      style: AppTextStyles.cairo16Bold,
                    ),
                  ),
                  const Customweekschduale(),
                  const Padding(
                    padding: EdgeInsets.only(right: 20, top: 20),
                    child: Text(
                      "اراء الاباء :",
                      style: AppTextStyles.cairo16Bold,
                    ),
                  ),
                  const ReviewCard(),
                  const ReviewCard(),
                  const ReviewCard(),
                  const ReviewCard(),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
