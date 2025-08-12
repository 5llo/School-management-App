import 'package:e_commerce/data/model/studentsdetailsmodel.dart';
import 'package:get/get.dart';


class StudentController extends GetxController {

  var students = <StudentDetailsModel>[].obs;
  var selectedMaterial = ''.obs;
  var materials = ['الرياضيات', 'العلوم', 'اللغة العربية','ديانة','انكليزي'].obs;

  @override
  void onInit() {
    super.onInit();
    selectedMaterial.value = materials.first;
    fetchStudents();
  }

  void fetchStudents() {
    students.value = [
      StudentDetailsModel(
        name: 'محمود بيوض',
        imageUrl: 'https://via.placeholder.com/50',
        attendanceRate: 0.75,
        oralMark: 4,
      ),
      StudentDetailsModel(
        name: 'محمد خليل',
        imageUrl: 'https://via.placeholder.com/50',
        attendanceRate: 0.75,
        oralMark: 4,
      ),
      StudentDetailsModel(
        name: 'جنا الفقير',
        imageUrl: 'https://via.placeholder.com/50',
        attendanceRate: 0.75,
        oralMark: 4,
        isFavorite: true,
      ),
    ];
  }
}