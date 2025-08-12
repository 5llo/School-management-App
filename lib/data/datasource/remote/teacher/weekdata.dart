import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class Weekdata {
   Crud crud;

   Weekdata(this.crud);

   getdata()async{
     var response = await crud.getData(AppLink.getWeekSchedule);
      return  response.fold((l)=>l, (r)=>r);
   }



    getdataForParent(String studentId)async{
     var response = await crud.postData(AppLink.getWeekScheduleForparent,{"student_id":studentId});
      return  response.fold((l)=>l, (r)=>r);
   }
    getexamsceduleparent(String studentId)async{
     var response = await crud.postData(AppLink.getExamScheduleByStudent,{"student_id":studentId});
      return  response.fold((l)=>l, (r)=>r);
   }
   
   
   
   
   }