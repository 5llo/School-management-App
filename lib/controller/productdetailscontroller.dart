import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/cartdata.dart';
import 'package:e_commerce/data/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController{
  
}


class ProductdetailscontrollerImp extends ProductDetailsController {

  // Cartcontroller cartcontroller = Get.put(Cartcontroller());
  late Statusrequest statusrequest;
ProductModel? productModel;
  CardData cardData = CardData(Get.find());

 int counter = 1;
 
  addcounter() {
    counter++;
    update();
  }

  deletecounter() {
    if (counter > 1) {
      counter--;
      update();
    }
    else{
       Get.rawSnackbar(
        title: 'Warning',
        messageText: const Text(
          "At least one porduct !!",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        icon: const Icon(
          Icons.event_available,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 194, 8, 8),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderRadius: 12,
        duration: const Duration(milliseconds: 1500),
        animationDuration: const Duration(milliseconds: 700),
        instantInit: false,
      );
    }
  }

  
  add(String prodId, int quantity) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await cardData.addCart(prodId, quantity);

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      Get.rawSnackbar(
        title: 'success',
        messageText: const Text(
          "Addded to Cart successfully",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        icon: const Icon(
          Icons.event_available,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 3, 164, 28),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        borderRadius: 12,
        duration: const Duration(milliseconds: 1500),
        animationDuration: const Duration(milliseconds: 700),
        instantInit: false,
      );
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }
initialData(){
productModel=Get.arguments['productmodel'];

}

List subproducts=[
{
  "name":"red",
  "id":1,
  "active":1
},
{
  "name":"yellow",
  "id":2,
  "active":0
},
{
  "name":"black",
  "id":3,
  "active":0
}

];
@override
  void onInit() {
    super.onInit();
    initialData();
  }

}