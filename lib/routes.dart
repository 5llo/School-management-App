import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/middleware/mymiddleware.dart';
import 'package:e_commerce/view/screen/Auth/login.dart';
import 'package:e_commerce/view/screen/Auth/signup.dart';
import 'package:e_commerce/view/screen/busdriver/editprofile.dart';
import 'package:e_commerce/view/screen/busdriver/homepagebus.dart';
import 'package:e_commerce/view/screen/busdriver/settings.dart';
import 'package:e_commerce/view/screen/onboarding.dart';
import 'package:e_commerce/view/screen/parent/childmenu.dart';
import 'package:e_commerce/view/screen/parent/homeparentpage.dart';
import 'package:e_commerce/view/screen/splashscreen.dart';
import 'package:e_commerce/view/screen/teacher/addhomework.dart';
import 'package:e_commerce/view/screen/teacher/daydetails.dart';
import 'package:e_commerce/view/screen/teacher/homescreenteacherpage.dart';
import 'package:e_commerce/view/screen/teacher/homework.dart';
import 'package:e_commerce/view/screen/teacher/setmarkpage.dart';
import 'package:e_commerce/view/screen/teacher/studentsdatailspage.dart';
import 'package:e_commerce/view/screen/teacher/studentspage.dart';
import 'package:e_commerce/view/screen/visitor/homepagevisitor.dart';
import 'package:e_commerce/view/screen/visitor/postdetails.dart';
import 'package:e_commerce/view/screen/visitor/schooldetails.dart';
import 'package:e_commerce/view/screen/teacher/hometeacherpage.dart';
import 'package:e_commerce/view/testview.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(

      // name: "/", page: () => const Cart(),
     name: "/",
    // page: () => const Homepagevisitor(),
      page: () => const SplashScreen(),
    middlewares: [Mymiddleware()]
      ),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.signUp, page: () => const Signup()),
  GetPage(name: AppRoute.test, page: () => const Testview()),
  GetPage(name: AppRoute.bushomepage, page: () => const Busmappage()),
  GetPage(name: AppRoute.editprofile, page: () => const Editprofile()),
  GetPage(name: AppRoute.settings, page: () => const Settings()),
  GetPage(name: AppRoute.visitorhomepage, page: () => const Homepagevisitor()),
  GetPage(name: AppRoute.postdetails, page: () => const Postdetails()),
  GetPage(name: AppRoute.schooldetails, page: () => const Schooldetails()),
    GetPage(name: AppRoute.homescreenteacherpage, page: () => const Homescreenteacherpage()),
    GetPage(name: AppRoute.homeparentpage, page: () => const Homeparentpage()),
    GetPage(name: AppRoute.daydetails, page: () =>  const Daydetails()),
    GetPage(name: AppRoute.homework, page: () =>  const Homework()),
    GetPage(name: AppRoute.teacherstudentsdetials, page: () =>    const StudentDetailsPage()),
    GetPage(name: AppRoute.teacherstudentPage, page: () =>     StudentPage()),
    GetPage(name: AppRoute.setmarkspage, page: () =>     SetMarkPage()),
    GetPage(name: AppRoute.addhomework, page: () =>     const AddHomeworkPage()),


///////////////parent pages//////////

    GetPage(name: AppRoute.childmenu, page: () =>     const Childmenu()),
];