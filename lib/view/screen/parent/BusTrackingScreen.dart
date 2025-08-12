import 'package:e_commerce/controller/parent/driverpathcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusTrackingScreen extends StatelessWidget {
  final String driverId;
  final double? schoolLat;
  final double? schoolLong;

  BusTrackingScreen({super.key, required this.driverId, this.schoolLat, this.schoolLong});

  @override
  Widget build(BuildContext context) {
    final DriverPathController controller = Get.put(DriverPathController(driverId));

    return Scaffold(
      appBar: AppBar(
        title: Text(' تتبع الحافلة'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // يضغط على زر إعادة التحديث لإعادة رسم المسار فوراً
              controller.redrawKey.value++;
            },
          )
        ],
      ),
      body: Obx(() {
        // ربط redrawKey ليعيد بناء الـUI فور تغييره
        controller.redrawKey.value;

        final driverPos = controller.driverPosition.value;
        if (driverPos == null) return Center(child: CircularProgressIndicator());

        Set<Marker> markers = {
          Marker(
            markerId: MarkerId('driver'),
            position: driverPos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(title: '🚍 السائق'),
          ),
          ...controller.studentMarkers,
        };

        if (schoolLat != null && schoolLong != null) {
          markers.add(Marker(
            markerId: MarkerId('school'),
            position: LatLng(schoolLat!, schoolLong!),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: '🏫 المدرسة'),
          ));
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(target: driverPos, zoom: 14),
          onMapCreated: (mapCtrl) {
            controller.setMapController(mapCtrl);
          },
          markers: markers,
          polylines: controller.polylines,
          myLocationEnabled: true,
        );
      }),
    );
  }
}
