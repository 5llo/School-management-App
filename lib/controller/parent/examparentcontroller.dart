import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/parent/resultdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/weekdata.dart';
import 'package:get/get.dart';

class Examparentcontroller extends GetxController{

 final String studentId;
  Examparentcontroller(this.studentId);

 Statusrequest ? statusrequest=Statusrequest.none;

  Weekdata weekdata = Weekdata(Get.find());

  List data = [];


getresults() async {

  statusrequest = Statusrequest.loading;
  update();
   var response = await weekdata.getexamsceduleparent(studentId);
    statusrequest = handlingData(response);
  //print("🚀 Response received: $response");

   if (statusrequest == Statusrequest.success) {
  // Flatten the nested map
  response['data'].forEach((day, exams) {
    data.addAll(exams); // This adds each exam entry to the data list
  });
}
else {
      statusrequest = Statusrequest.none;
    }

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getresults();
  }






}