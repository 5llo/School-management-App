// mappage.dart
import 'package:e_commerce/controller/studentscontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Studentscontroller>(
      builder: (studentscontroller) {
        Set<Marker> markers = studentscontroller.studentsdetails
            .where((student) =>
                student.latitude != null &&
                student.longitude != null &&
                student.latitude!.isNotEmpty &&
                student.longitude!.isNotEmpty)
            .map((student) {
          return Marker(
            markerId: MarkerId(student.parentPhone ?? 'student_${student.studentName}'),
            position: LatLng(
              double.parse(student.latitude!),
              double.parse(student.longitude!),
            ),
            infoWindow: InfoWindow(
              title: student.studentName,
              snippet: student.parentPhone,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          );
        }).toSet();

        if (studentscontroller.schoolLocation != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('school'),
              position: studentscontroller.schoolLocation!,
              infoWindow: InfoWindow(title: studentscontroller.schoolName ?? "المدرسة"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
          );
        }

        if (studentscontroller.userLocation != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('user'),
              position: studentscontroller.userLocation!,
              infoWindow: const InfoWindow(title: "أنا هنا"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            ),
          );
        }

        LatLng mapCenter = studentscontroller.userLocation ??
            studentscontroller.schoolLocation ??
            const LatLng(34.7304, 36.7090);

        return Scaffold(
          appBar: AppBar(
            elevation: 6,
            shadowColor: AppColor.color2,
            title: const Text(
              "خريطة أماكن الطلاب",
              style: AppTextStyles.cairo16Bold,
            ),
            backgroundColor: AppColor.color9,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.alt_route),
                tooltip: "ارسم المسار للطلاب",
                onPressed: () async {
                  await studentscontroller.drawRouteToAllStudents();
                },
              ),
              Obx(() => ElevatedButton(
                    onPressed: () {
                      studentscontroller.toggleRoute();
                    },
                    child: Text(studentscontroller.isGoingToSchool.value
                        ? 'ذهاب إلى المدرسة'
                        : 'عودة إلى المنزل'),
                  )),
            ],
          ),
          body: GoogleMap(
            onMapCreated: (controller) {
              if (!studentscontroller.mapController.isCompleted) {
                studentscontroller.mapController.complete(controller);
              }
            },
            initialCameraPosition: CameraPosition(
              target: mapCenter,
              zoom: 12.0,
            ),
            markers: markers,
            polylines: studentscontroller.polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),
        );
      },
    );
  }
}
