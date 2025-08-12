import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class MyFavoriteData {
   Crud crud;

   MyFavoriteData(this.crud);

   getdata()async{
     var response = await crud.postData(AppLink.favorite, {});
      return  response.fold((l)=>l, (r)=>r);
   }


   togglefavourite(String prodId)async{
     var response = await crud.postData(AppLink.togglefavourite, {"prodId":prodId});
      return  response.fold((l)=>l, (r)=>r);
   }
}