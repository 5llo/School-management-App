import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AttendanceData {
  Crud crud;

  AttendanceData(this.crud);

  getLast7Days(String childrenId) async {
    var response = await crud.postData(AppLink.getAttendanceForStudent, {
      "student_id": childrenId,
    });
    return response.fold((l) => l, (r) => r);
  }



  getAttendanceForDate(String childrenId, String date) async {
    var response = await crud.postData(AppLink.getAttendanceForSingleDate, {
      "student_id": childrenId,
       "date": date,
    });
    return response.fold((l) => l, (r) => r);
  }
}
