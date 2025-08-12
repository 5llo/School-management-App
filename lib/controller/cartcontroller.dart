import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/cartdata.dart';
import 'package:e_commerce/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  CardData cardData = CardData(Get.find());
  List<CartModel> data = [];
  TextEditingController? conponcontroller;
  double priceorder = 0.0;
  int totalcountproducts = 0;

  int counter = 1;

  late Statusrequest statusrequest;

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

  delete(String prodId) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await cardData.deleteCart(prodId);

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

  cartview() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await cardData.viewCart();

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      List responedata = response['data']['cart'];
      priceorder = double.parse(response['data']['total_price']);
      data.clear();
      totalcountproducts = responedata.length;
      data.addAll(responedata.map((e) => CartModel.fromJson(e)));
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

refreshpage(){
  resetVarCart();
  cartview();

}
  resetVarCart(){
    totalcountproducts =0;
    priceorder = 0.0;
    data.clear();

  }

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

  @override
  void onInit() {
    conponcontroller = TextEditingController();
    cartview();
    super.onInit();
  }
}
