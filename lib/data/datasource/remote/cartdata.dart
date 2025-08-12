// ignore_for_file: file_names

import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class CardData {
  Crud crud;

  CardData(this.crud);

  addCart(String prodId, int quantity) async {
    var response = await crud
        .postData(AppLink.cardadd, {"prodId": prodId, "quantity": quantity});
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(String prodId) async {
    var response = await crud.postData(AppLink.carddelete, {"prodId": prodId});
    return response.fold((l) => l, (r) => r);
  }
  viewCart() async {
    var response = await crud.postData(AppLink.cardtview, {});
    return response.fold((l) => l, (r) => r);
  }
}
