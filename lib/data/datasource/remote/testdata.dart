import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Testdata {
   Crud crud;

   Testdata(this.crud);

   getdata()async{
     var response = await crud.postData(AppLink.test, {});
      return  response.fold((l)=>l, (r)=>r);
   }
}