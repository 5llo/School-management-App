
import 'package:e_commerce/core/class/google_signin_service.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/testview.dart';
import 'package:e_commerce/view/widget/auth/custombuttomloginregister.dart';
import 'package:e_commerce/view/widget/auth/customchoose.dart';
import 'package:e_commerce/view/widget/auth/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/Auth/logincontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
       Get.put(LogincontrollerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GetBuilder<LogincontrollerImp>(
          builder: (controller) => HandlingDataRequest(
            statusrequest: controller.statusrequest!,
            widget: SingleChildScrollView(
              child: Form(
                key: controller.formstate,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                    
                      
                      SvgPicture.asset(
                          AppImageassets.loginregisterlogo,
                          height: 110,
                        ),
                    
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                              controller.group.length,
                              (index) => CustomChoose(
                                    index: index,
                                    imagepath: controller.group[index]['icon'],
                                    label: controller.group[index]['name'],
                                    type: controller.type,
                                    onTap: () {
                                      print("con.type:");
                                      print(controller.type);
                                      print("index :");
                                      print(index);
                                      controller.settype(index);
                                    },
                                  ))
                        ],
                      ),

                      const SizedBox(height: 20),
                   
                     Customtextfield(controllerfield: controller.email, hinttext: 'البريد الالكتروني', validatetype: 'email', icon: Icons.person_outline, labeltext: 'البريد الالكتروني', ispass: false, typenumber: false,),

                      const SizedBox(height: 16),
                     
                      
                      Customtextfield(controllerfield: controller.password, hinttext: 'كلمة المرور', validatetype: 'password', icon: Icons.lock_outline, labeltext: 'كلمة المرور', ispass: true, typenumber: false,),
                    

                      Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {},
                          child: const Text("نسيت كلمة المرور",
                              style: TextStyle(color: AppColor.color8)),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Custombuttomloginregister(onPressed:  () => controller.login(), title: 'تسجيل الدخول'),

                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "   ليس لديك حساب؟",
                            style: AppTextStyles.cairo14,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                               controller.toPageSignUp();
                              },
                              child: Text("إنشاء حساب  ",
                                  style: AppTextStyles.cairo14Bold
                                      .copyWith(color: AppColor.color9)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "او المتابعة بواسطة",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ✅ تسجيل الدخول بواسطة جوجل وآبل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Material(
  color: Color(0xffF8F4F8),
  borderRadius: BorderRadius.circular(33),
  child: InkWell(
    borderRadius: BorderRadius.circular(33),
    onTap: () {
      GoogleSignInService.signInAndSendTokenToLaravel(controller.type);
    },
    child: Container(
      width: 158,
      height: 56,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
      ),
      child: SvgPicture.asset(AppImageassets.google),
    ),
  ),
),

                          const SizedBox(
                            width: 24,
                          ),
                         Material(
  color: AppColor.textfield,
  borderRadius: BorderRadius.circular(55),
  child: InkWell(
    borderRadius: BorderRadius.circular(55),
    onTap: () {
      // حط هنا الكود الخاص بـ Apple Sign-In إذا احتجت
    },
    child: Container(
      width: 158,
      height: 56,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
      ),
      child: SvgPicture.asset(AppImageassets.apple2),
    ),
  ),
),

                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "او",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      Center(
                        child: TextButton(
                          onPressed: () {
                          Get.toNamed(AppRoute.visitorhomepage);
                          },
                          child: const Text("المتابعة كزائر",
                              style: TextStyle(color: Colors.purple)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
