import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/view/widget/auth/custombuttomloginregister.dart';
import 'package:e_commerce/view/widget/auth/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Editprofile extends StatelessWidget {
  
  const Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: SvgPicture.asset(AppImageassets.backpageicon,width: 10,)),
        title: const Text("تعديل الملف الشخصي"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 48,),
            Customtextfield( hinttext: 'علي الجاسم', validatetype: 'non', icon: Icons.person_outline, labeltext: 'اسم المستخدم', ispass: false, typenumber: false,),
            const SizedBox(height: 32,),
                        Customtextfield( hinttext: '0938794815', validatetype: 'non', icon: Icons.phone_outlined, labeltext: 'رقم الهاتف', ispass: false, typenumber: true,),
                         const SizedBox(height: 32,),
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
      )
    );
  }
}