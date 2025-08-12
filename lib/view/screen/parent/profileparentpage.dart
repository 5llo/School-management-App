import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/view/widget/bus/Custombuttonprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profileparentpage extends StatelessWidget {
  const Profileparentpage({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(height: 200,),
          Custombuttonprofile(
            icon: AppImageassets.logouticonprofile,
            title: "تسجيل الخروج",
            onTap: () {
              Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber),
            SizedBox(width: 10),
            Text(
              "تأكيد تسجيل الخروج",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          "هل أنت متأكد أنك تريد تسجيل الخروج؟",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed:()async {
         
        GoogleSignIn googleSignIn = GoogleSignIn();
      
        // تحقق إذا فيه مستخدم Google مسجّل
        if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
        }
      
        // مسح البيانات المحلية
        myServices.sharedPreferences.clear();
      
        // الرجوع إلى صفحة تسجيل الدخول
        Get.offAllNamed(AppRoute.login);
      
      
        },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("تسجيل الخروج"),
          ),
        ],
      ),
          );
            },
          ),
        ],
      ),
    );
  }
}
