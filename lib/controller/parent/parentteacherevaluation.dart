import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:get/get.dart';

class TeacherRatingController extends GetxController {
  String teacherName = "محمد خليل";
  String teacherImage =AppImageassets.profileimage; // عدل حسب الصورة الحقيقية

  List<Map<String, dynamic>> ratings = [
    {
      "name": "سليم العلي",
      "time": "6:47",
      "text": "أستاذ رائع بكل معنى الكلمة",
      "stars": 4,
      "likes": 30,
      "dislikes": 55,
      "userImage": AppImageassets.profileimage,
    },
    {
      "name": "سليم العلي",
      "time": "6:47",
      "text": "أستاذ رائع بكل معنى الكلمة",
      "stars": 4,
      "likes": 30,
      "dislikes": 55,
      "userImage": AppImageassets.profileimage,
    },
    {
      "name": "سليم العلي",
      "time": "6:47",
      "text": "أستاذ رائع بكل معنى الكلمة",
      "stars": 4,
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