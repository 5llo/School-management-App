import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/homeworkdata.dart';
import 'package:e_commerce/data/model/homeworkmodel.dart';
import 'package:get/get.dart';

class Homeworkparentcontroller extends GetxController {
  final String childrenId;
  Homeworkparentcontroller(this.childrenId);

  HomeworkData homeworkdata = HomeworkData(Get.find());

  late Statusrequest statusRequest;
  List<HomeworkModel> homeworks = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

 Future<void>  getData() async {
    statusRequest = Statusrequest.loading;
    update();

    var response = await homeworkdata.gethomeworkForParent(childrenId);

    statusRequest = handlingData(response);
    if (statusRequest == Statusrequest.success) {
      List listdata = response['data'];
      homeworks = listdata.map((e) => HomeworkModel.fromJson(e)).toList();
    }

    update();
  }

  
}
