import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/product-data.dart';
import 'package:e_commerce/data/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homecontroller.dart';

abstract class Productscontroller extends GetxController {
  initialData();
  changeCat(int val, String catval);
  getProducts(String catId);
  goToPageProductDetails(ProductModel productmodel);
}

class ProductControllerImp extends SearchMixController   {
  List categories = [];
  int? selectedCat;
  String? catId;

  ProductData productData = ProductData(Get.find());

  List data = [];
  @override
  late Statusrequest statusrequest;

  getData() async {}

  @override
  initialData() {
    categories = Get.arguments['categories'];
    selectedCat = Get.arguments['selectedCat'];
    catId = Get.arguments['catId'];
    getProducts(catId!);
  }

  @override
  void onInit() {
    search = TextEditingController();
    // initialData();
    super.onInit();
  }

 int selectedTab = 0;

  void changeTab(int index) {
    selectedTab = index;
    update();
  }

  List<String> tabs = ["وصف", "صور", "التعليقات"];
  
  

  
  getProducts(catId) async {
    data.clear();

    statusrequest = Statusrequest.loading;
    update();

    var response = await productData.getdata(catId);

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data']['products'].length == 0) {
        statusrequest = Statusrequest.none;
      } else {
        data.addAll(response['data']['products']);
      }
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  @override
  goToPageProductDetails(productmodel) {
    Get.toNamed(AppRoute.productdetails,
        arguments: {'productmodel': productmodel});
  }

  gotofavorite() {
    Get.toNamed(AppRoute.myfavourite);
  }
}
