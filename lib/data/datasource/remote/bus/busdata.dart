import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Busdata {
   Crud crud;

   Busdata(this.crud);

   getdata()async{
     var response = await crud.getData(AppLink.businfo);
      return  response.fold((l)=>l, (r)=>r);
   }}