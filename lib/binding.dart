// import 'package:e_commerce/core/class/crud.dart';

import 'package:e_commerce/core/class/crud.dart';
import 'package:get/get.dart';

class Mybinding extends Bindings{
  @override
  void dependencies() {
     // Get.lazyPut(()=>LogincontrollerImp(),fenix: true);
 // Get.lazyPut(()=>SignupcontorllerImp(),fenix: true);
 
    Get.put(Crud());
  
  }

}