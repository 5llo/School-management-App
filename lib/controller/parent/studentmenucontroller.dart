import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/parent/childrendata.dart';
import 'package:e_commerce/data/model/parentModels/childrensmodel.dart';
import 'package:get/get.dart';

class Studentmenucontroller extends GetxController{
 List<Map<String, dynamic>> mainlista = [
  {"id": "homework", "title": "الواجبات اليومية", "icon": AppImageassets.parentbook},
  {"id": "attendance", "title": "الخضور والغياب", "icon": AppImageassets.parentattencance},
  {"id": "exam_schedule", "title": "جدول الامتحانات", "icon": AppImageassets.parentexamtable},
  {"id": "study_schedule", "title": "الجدول الدراسي", "icon": AppImageassets.parentweeksceduale},
  {"id": "behavior", "title": "سلوك الطالب", "icon": AppImageassets.parentoral},
  {"id": "exam_results", "title": "نتائج الامتحانات", "icon": AppImageassets.parentexam},
  {"id": "activities", "title": "النشاطات", "icon": AppImageassets.parentactivity},
  {"id": "daily_meals", "title": "الوجبات اليومية", "icon": AppImageassets.parentfood},
  {"id": "posts", "title": "المنشورات", "icon": AppImageassets.parentposts},
  {"id": "bus_tracking", "title": "تتبع الحافلة", "icon": AppImageassets.parentbus},
  {"id": "contests", "title": "المسابقات", "icon": AppImageassets.parentcontest},
  {"id": "chat_teacher", "title": "التواصل مع المدرس", "icon": AppImageassets.parentteacher},
  {"id": "evaluate_teacher", "title": "تقييم المدرس", "icon": AppImageassets.parentevualtionteacher},
  {"id": "contact_school", "title": "التواصل مع المدرسة", "icon": AppImageassets.parentschool},
  {"id": "evaluate_school", "title": "تقييم المدرسة", "icon": AppImageassets.parentevaluationschool},
  // {"id": "home", "title": "الرئيسية", "icon": AppImageassets.parenthomework},
];






  Childrendata childrendata = Childrendata(Get.find());

  late Statusrequest statusrequest;

  List<ChildrenModel> childrens = [];

  getData() async {
     statusrequest = Statusrequest.loading;
    update();

    var response = await childrendata.getdata();
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'] == null) {
        statusrequest = Statusrequest.none;
      } if (response['data'] != null) {
  childrens.clear();
  childrens = (response['data'] as List)
      .map((e) => ChildrenModel.fromJson(e))
      .toList();
  print("✅ Students loaded: ${childrens.length}");
}

    }
    update();
  }












  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    //   FirebaseMessaging.instance.getToken().then((value){
    // print( "the ✅ Token-device is : $value");
  
    //  });
}

}