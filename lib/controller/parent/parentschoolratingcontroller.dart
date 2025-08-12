import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:get/get.dart';

class SchoolRatingController extends GetxController {
  String schoolName = "مدرسة الامل ";
  String teacherImage =AppImageassets.profileimage; // عدل حسب الصورة الحقيقية

  List<Map<String, dynamic>> ratings = [
    {
      "name": "محمد العلي",
      "time": "6:22",
      "text": "مدرسة رائعة بكل معنى الكلمة",
      "stars": 5,
      "likes": 30,
      "dislikes": 55,
      "userImage": AppImageassets.profileimage,
    },
    {
      "name": "سليم الاحمد",
      "time": "6:44",
      "text": " مدرسة تقدر الطالب وجهوده",
      "stars": 5,
      "likes": 30,
      "dislikes": 55,
      "userImage": AppImageassets.profileimage,
    },
    {
      "name": "وئام عراج",
      "time": "6:47",
      "text": "في كتير فوضى بالمدرسة منتمنى انو يتدارك الوضع",
      "stars": 2,
      "likes": 30,
      "dislikes": 55,
      "userImage": AppImageassets.profileimage,
    }
  ];

  int selectedStars = 0;
  String comment = "";

  void setStars(int value) {
    selectedStars = value;
    update();
  }

  void setComment(String value) {
    comment = value;
    update();
  }

  void submitRating() {
    print("⭐ تقييمك: $selectedStars نجوم، تعليقك: $comment");
    // هنا تضيف الكود الذي سيرسل إلى API مستقبلاً
  }
}