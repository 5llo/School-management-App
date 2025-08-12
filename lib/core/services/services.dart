import 'package:e_commerce/core/class/notificationhandler.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;
//here all service that i want to start when app is start
class MyServices extends GetxService{

  late SharedPreferences sharedPreferences;

  Future<MyServices> init()async{
    await AppLink.init();
  //  NotificationsHelper.getAccessToken();
   timeago.setLocaleMessages('ar', timeago.ArMessages());
    await Firebase.initializeApp();
      await NotificationsHelper.initializeNotification();
      await requestNotificationPermissions();
     await initializeDateFormatting('en', null);
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}


initialServices()async{
 await Get.putAsync(()=>MyServices().init());
}






Future<void> requestNotificationPermissions() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
