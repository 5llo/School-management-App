import 'package:e_commerce/controller/settingscontroller.dart';
import 'package:e_commerce/controller/studentscontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/view/widget/bus/Custombuttonprofile.dart';
import 'package:e_commerce/view/widget/bus/customcardprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  Settingscontroller settingscontroller = Get.put(Settingscontroller());
  Studentscontroller studentscontroller = Get.put(Studentscontroller());
  // Studentscontroller studentscontroller = Get.find();
  MyServices myServices = Get.find();
   ProfilePage({super.key});

  @override
   Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لدعم اللغة العربية
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
         
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color:AppColor.color9, // بنفسجي
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Stack(
                       
                        children: [
                          Container(
                         
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.white,
      width: 5,
    ),
  ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(AppImageassets.profileimage),
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 4,
                            child: CircleAvatar(
                              
                              radius: 14,
                              backgroundColor:AppColor.color9,
                              child: Icon(Icons.edit, size: 16,color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                     
                    ],
                  ),
                )
              ],
            ), const SizedBox(height: 48),
                       Text("${myServices.sharedPreferences.getString("username")}", style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("سائق باص", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 24),

           
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Customcardprofile(title: 'رقم الباص', body: '12121212',),
                  const SizedBox(width: 10),
                 Customcardprofile(title: 'عدد الطلاب', body: '${studentscontroller.studentsdetails.length}',),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children:  [
                  Custombuttonprofile(icon:AppImageassets.editiconprofile,title:  "تعديل الملف الشخصي", onTap: () { Get.toNamed(AppRoute.editprofile,) ;},),
                  Custombuttonprofile(icon:AppImageassets.helpiconprofile, title: "المساعدة", onTap: () {  },),
                  Custombuttonprofile(icon:AppImageassets.settingfilled, title: "الإعدادات", onTap: () { Get.toNamed(AppRoute.settings); },),
                  Custombuttonprofile(icon:AppImageassets.logouticonprofile,title:  "تسجيل الخروج", onTap: () { settingscontroller.showLogoutDialog(); },),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  
  
  
  }


}
