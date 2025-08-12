import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/parent/resultdata.dart';
import 'package:get/get.dart';

class Resultcontroller extends GetxController{

 final String studentId;
  Resultcontroller(this.studentId);

 Statusrequest ? statusrequest=Statusrequest.none;

     Resultdata resultdata = Resultdata(Get.find());

  List data = [];
  String ? finalTotalMarks;


getresults() async {

  statusrequest = Statusrequest.loading;
  update();
  var response = await resultdata.getdata(studentId);
   statusrequest = handlingData(response);
  //print("🚀 Response received: $response");

   if (statusrequest == Statusrequest.success) {
      data.addAll(response['data']);
      finalTotalMarks = response['finalTotalMarks'].toString();
      print("################################################");
       print(data);
      print("################################################");
       print(finalTotalMarks);
      print("################################################");
           

    } else {
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