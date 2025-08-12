// ignore_for_file: file_names

import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class FavoriteData {
   Crud crud;

   FavoriteData(this.crud);

   togglefavourite(String prodId)async{
     var response = await crud.postData(AppLink.togglefavourite, {"prodId":prodId});
      return  response.fold((l)=>l, (r)=>r);
   }

}