import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapcontroller extends GetxController {
  final Completer<GoogleMapController> completercontroller =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target:  LatLng(34.7324, 36.7138),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );


  // Future<void> requestLocationPermission() async {
  //   var status = await Permission.location.request();

  //   if (status.isGranted) {
  //     print("✅ تم السماح بالوصول للموقع");
  //   } else if (status.isDenied) {
  //     print("❌ تم رفض الوصول للموقع");
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings(); // يفتح إعدادات التطبيق ليتغير يدوياً
  //   }
  // }
}
