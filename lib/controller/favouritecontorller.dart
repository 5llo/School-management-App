import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/favorite-data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favouritecontorller extends GetxController {
  FavoriteData favoriteData = FavoriteData(Get.find());

  List data = [];
  late Statusrequest statusrequest;

  Map isfavourite = {};

  setvavourite(id, val) {
    isfavourite[id] = val;
    update();
  }

  togglefavourite(String prodId) async {
    data.clear();

    statusrequest = Statusrequest.loading;
    update();

    var response = await favoriteData.togglefavourite(prodId);

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
     
    Get.rawSnackbar(
      title: 'success',
      messageText: const Text("saved successfully",style: TextStyle(color: Colors.white,fontSize: 14),),
      icon: const Icon(Icons.event_available,color: Colors.white,),
      backgroundColor: const Color.fromARGB(255, 3, 164, 28),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      borderRadius: 12,
      duration : const Duration(milliseconds: 1500),
      animationDuration :const Duration(milliseconds: 700),
      instantInit:false,
    );
      
    } else {
      statusrequest = Statusrequest.failure;
    }
    
    update();
  }

  gotofavorite() {
    Get.toNamed(AppRoute.myfavourite);
  }
}
