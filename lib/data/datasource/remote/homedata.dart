import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Homedata {
   Crud crud;

   Homedata(this.crud);

   getdata()async{
     var response = await crud.postData(AppLink.homepage, {});
      return  response.fold((l)=>l, (r)=>r);
   }
   searchData(String search)async{
     var response = await crud.postData(AppLink.search, {"query":search});
      return  response.fold((l)=>l, (r)=>r);
   }
}