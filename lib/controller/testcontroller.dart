import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/testdata.dart';
import 'package:get/get.dart';

class Testcontroller extends GetxController {
  Testdata testdata = Testdata(Get.find());

  List data = [];
  late Statusrequest statusrequest;

getData() async {
  statusrequest = Statusrequest.loading;
  update();
  
  var response = await testdata.getdata();


  statusrequest = handlingData(response);

  if (statusrequest == Statusrequest.success) {
    if (response['status'] == 'success') {
      data.addAll(response['data']);
    } else {
      statusrequest = Statusrequest.failure;
    }
  }
  update();
}

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
