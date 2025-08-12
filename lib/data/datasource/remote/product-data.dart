// ignore_for_file: file_names

import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class ProductData {
   Crud crud;

   ProductData(this.crud);

   getdata(String catId)async{
     var response = await crud.postData(AppLink.products, {"cat_id":catId});
      return  response.fold((l)=>l, (r)=>r);
   }
}