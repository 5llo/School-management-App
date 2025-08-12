import 'dart:convert';
import 'package:http/http.dart' as http;

   class AppLink {
  static String orginal = "";
  static String server = "";
  static String test = "";

  static String signup = "";
  static String login = "";
  static String homepage = "";
  static String catimage = "";
  static String prodimage = "";
  static String products = "";
  static String togglefavourite = "";
  static String favorite = "";
  static String search = "";
  static String cardtview = "";
  static String cardadd = "";
  static String carddelete = "";

  static String businfo = "";
  static String getWeekSchedule = "";
  static String getstudentandoralgrade = "";
  static String sendstateandoralgrade = "";
  static String gettopstudents = "";
  static String getstudentswithdetails = "";
  static String updateStudentGrades = "";
  static String sendallgradeforallstudents = "";
  static String gethomeworks = "";
  static String uploadhomework = "";
  static String getchildrenforparents = "";
  static String getresult = "";
  static String gethomeworkForParent= "";
  static String getWeekScheduleForparent= "";
  static String getExamScheduleByStudent= "";
  static String getSchoolsClassesDivisionPost= "";
  static String getAttendanceForStudent= "";
  static String getAttendanceForSingleDate= "";

  static Future<void> init() async {
    try {
      // رابط GitHub إلى ملف JSON
final url = 'https://raw.githubusercontent.com/5llo/httpsUrl/master/ngrok.json';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        orginal = data['base_url'];
        server = "$orginal/api";
        test = "$server/test";

        signup = "$server/register";
        login = "$server/login";
        homepage = "$server/homepage";
        catimage = "$orginal/categories";
        prodimage = "$orginal/products";

        products = "$server/product-category";
        togglefavourite = "$server/product/togglefavourite";
        favorite = "$server/favourites";
        search = "$server/product/search";

        cardtview = "$server/cart";
        cardadd = "$server/cart/add";
        carddelete = "$server/cart/delete";

        businfo = "$server/getDriverStudents";
        getWeekSchedule = "$server/getWeek_Schedule";
        getstudentandoralgrade = "$server/getstudent-andoralgrade";
        sendstateandoralgrade = "$server/setstudentsattendancesandoralgrade";
        gettopstudents = "$server/getTopFeaturedStudents";
        getstudentswithdetails = "$server/getALLStudentInfo";
        updateStudentGrades = "$server/updateStudentGrades";
        sendallgradeforallstudents = "$server/updateGradesForDivision";
        gethomeworks = "$server/teacher/homeworks";
        uploadhomework = "$server/homeworks";
        getchildrenforparents = "$server/childrenByParent";
        getresult = "$server/showFinallyResult";
        gethomeworkForParent = "$server/getHomeWorkForStudent";
        getWeekScheduleForparent = "$server/getWeekScheduleByStudent";
        getExamScheduleByStudent = "$server/getExamScheduleByStudent";
        getSchoolsClassesDivisionPost = "$server/getSchoolsClassesDivisionPost";
        getAttendanceForStudent = "$server/getAttendanceForStudent";
        getAttendanceForSingleDate = "$server/getAttendanceForSingleDate";
        
      } else {
        throw Exception("Failed to load ngrok URL");
      }
    } catch (e) {
      print("Error loading AppLink config: $e");
    }
  }
}
