import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/data/datasource/remote/homedata.dart';
import 'package:e_commerce/data/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends SearchMixController {
  initialData();
  getData();
  gotoproducts(List categories, int selectedCat, String catId);
}

class HomecontrollerImp extends HomeController {
  List data = [];
  List categories = [];
  List products = [];

  MyServices myServices = Get.find();
  String? username;
  String? id;
  String? phone;
  String? email;
  String? token;

  @override
  initialData() {
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
    phone = myServices.sharedPreferences.getString("phone");
    email = myServices.sharedPreferences.getString("email");
    token = myServices.sharedPreferences.getString("token");
  }

  @override
  void onInit() {
    search = TextEditingController();
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await homedata.getdata();

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      categories.addAll(response['data']['categories']);
      products.addAll(response['data']['products']);
      //    print(categories);
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  @override
  gotoproducts(List categories, selectedCat, catId) {
    Get.toNamed(AppRoute.productsPage, arguments: {
      "categories": categories,
      "selectedCat": selectedCat,
      "catId": catId
    });
  }

  gotofavorite() {
    Get.toNamed(AppRoute.myfavourite);
  }

  goToPageProductDetails(productmodel) {
    Get.toNamed(AppRoute.productdetails,
        arguments: {'productmodel': productmodel});
  }
}

class SearchMixController extends GetxController {
  Homedata homedata = Homedata(Get.find());

  List<ProductModel> productListSearchdata = [];

  late Statusrequest statusrequest;
  TextEditingController? search;

  bool isSearch = false;
  checkSearch(val) {
    if (val == "") {
      isSearch = false;
      statusrequest = Statusrequest.success;
    }
    update();
  }

  onSearchProduct() {
    if (search!.text != "") {
      isSearch = true;
      searchProductfunc();
      update();
    }
    
  }

  searchProductfunc() async {
//
    statusrequest = Statusrequest.loading;
    update();
    var response = await homedata.searchData(search!.text);

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      List resdata = response['data'];
      if (resdata.isEmpty) {
        statusrequest = Statusrequest.none;
      }
      productListSearchdata.clear();

      productListSearchdata
          .addAll(resdata.map((e) => ProductModel.fromJson(e)));
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }
}
