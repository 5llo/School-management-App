import 'package:e_commerce/controller/settingscontroller.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/widget/auth/custombuttomloginregister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Settingscontroller settingscontroller=Get.put(Settingscontroller());
    return Scaffold(
      appBar: AppBar(
        
           leading: IconButton(onPressed: (){Get.back();}, icon: SvgPicture.asset(AppImageassets.backpageicon,width: 10,)),
        title: const Text("الاعدادات"),
      ),
      body: GetBuilder<Settingscontroller>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.all(20),
            child:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppImageassets.themeiconprofile),
                        const SizedBox(width: 12,),
                        const Text("المظهر",style: AppTextStyles.cairo16semi,)
                      ],
                    ),
                     Transform.scale(
                       scale: 0.8,
                       child: Switch(
                        value: controller.value1,
                        onChanged: (bool value) {
                          controller.changeswitchone();
                        
                        },
                        activeColor: Colors.green,
                                       ),
                     ),
                  ],
                ),
             const Divider(),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppImageassets.languageiconprofile),
                        const SizedBox(width: 12,),
                        const Text("اللغة",style: AppTextStyles.cairo16semi,)
                      ],
                    ),
                   Container(
                    height: 42,
  padding: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(8),
  ),
  child: DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      value: controller.selectedLanguage,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.changeLanguage(newValue);
        }
      },
      items: <String>['العربية', 'English']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: AppTextStyles.cairo14,),
        );
      }).toList(),
    ),
  ),
)
                  ],
                ),
                const Divider(),




                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppImageassets.locationiconprofile),
                        const SizedBox(width: 12,),
                        const Text("الموقع",style: AppTextStyles.cairo16semi,)
                      ],
                    ),
                     Transform.scale(
                       scale: 0.8,
                       child: Switch(
                        value: controller.value3,
                        onChanged: (bool value) {
                          controller.changeswitchthree();
                        
                        },
                        activeColor: Colors.green,
                                       ),
                     ),
                  ],
                ),

                        const SizedBox(height: 24,),
                  Padding(
                           padding: const EdgeInsets.all(48),
                           child: Row(
                             children: [
                              
                               Expanded(child: Custombuttomloginregister(onPressed: () {  }, title: 'تأكيد',)),
                             ],
                           ),
                         )
                  
                
          
              ],
            ),
          );
        }
      ),
    );
  }
}