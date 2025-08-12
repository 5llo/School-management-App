import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/myfavoritedata.dart';
import 'package:e_commerce/data/model/myfavoritemodel.dart';
import 'package:get/get.dart';

class MyFavouritecontorller extends GetxController {
  MyFavoriteData favoriteData = MyFavoriteData(Get.find());
  List<MyFavoriteModel> data = [];
  late Statusrequest statusrequest;

  getdata() async {
    data.clear();

    statusrequest = Statusrequest.loading;
    update();

    var response = await favoriteData.getdata();

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'].length == 0) {
        statusrequest = Statusrequest.none;
      } else {
            List responsedata = response['data'];
        data.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(
            e))); //if i has 4 products in the fav: this will return 4 object(isntance)  : the new data : [Instance of 'MyFavoriteModel', Instance of 'MyFavoriteModel', Instance of 'MyFavoriteModel', Instance of 'MyFavoriteModel']
      
      }
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  togglefavourite(String prodId) {
     favoriteData.togglefavourite(prodId);

  

    data.removeWhere((element) => element.id.toString() == prodId);
    update();
  }

  @override
  void onInit() {
    getdata();
    super.onInit();
  }
}
