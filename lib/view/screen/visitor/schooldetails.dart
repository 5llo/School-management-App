import 'package:e_commerce/controller/productscontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/widget/visitor/commenttab.dart';
import 'package:e_commerce/view/widget/visitor/descriptiontab.dart';
import 'package:e_commerce/view/widget/visitor/phototab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Schooldetails extends StatelessWidget {
  const Schooldetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductControllerImp());

    return SingleChildScrollView(
      child:  Container(
        color:  const Color(0xFFF5F5F5),
        child: Column(
            children: [
              // الصورة الرئيسية
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 280,
                    child: Image.asset(AppImageassets.schoolone,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppImageassets.shareicon),
                            const SizedBox(width: 24),
                            SvgPicture.asset(AppImageassets.favoriteicon),
                          ],
                        ),
                       IconButton(onPressed: (){Get.back();}, icon: SvgPicture.asset(AppImageassets.backnewicon)) ,
                      ],
                    ),
                  ),
                ],
              ),
           //   const SizedBox(height: 10),
          
              // العنوان والموقع
              Container(
                
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("مدرسة الامل",
                        style: AppTextStyles.cairo20Bold.copyWith(
                            color: const Color(0xFF3B3A3A),
                            decoration: TextDecoration.none)),
                    Text("حمص-شارع الدبلان",
                        style: AppTextStyles.cairo14.copyWith(
                            color: AppColor.color2,
                            decoration: TextDecoration.none)),
                  ],
                ),
              ),
          
              const SizedBox(height: 20),
          
              // التابات
              GetBuilder<ProductControllerImp>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(controller.tabs.length, (index) {
                      bool selected = controller.selectedTab == index;
                      return GestureDetector(
                        onTap: () => controller.changeTab(index),
                        child: Column(
                          children: [
                            Text(
                              controller.tabs[index],
                              style: selected ? AppTextStyles.cairo16Bold.copyWith(color: AppColor.color9,decoration: TextDecoration.none):AppTextStyles.cairo16.copyWith(color: AppColor.color2,decoration: TextDecoration.none),
                                
                            ),
                            if (selected)
                              Container(
                                height: 2,
                                width: 80,
                                margin: const EdgeInsets.only(top: 5),
                                color: AppColor.color9,
                              ),
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
          
              const SizedBox(height: 20),
          
              // محتوى التاب
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<ProductControllerImp>(
                  builder: (controller) {
                    switch (controller.selectedTab) {
                      case 0:
                        return const DescriptionTab();
                      case 1:
                        return PhotosTab();
                      case 2:
                        return  CommentsTab();
                      default:
                        return const DescriptionTab();
                    }
                  },
                ),
              ),
            ],
          ),
      ),
      );
    
  }
}
