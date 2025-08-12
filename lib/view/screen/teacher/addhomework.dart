import 'dart:io';
import 'dart:ui';
import 'package:e_commerce/controller/teacher/homeworkcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class AddHomeworkPage extends StatelessWidget {
  const AddHomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).devicePixelRatio * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('إدراج وظيفة جديدة'),
      ),
      body: GetBuilder<HomeworkController>(
        builder: (controller) {
          return Handlingdataview(statusrequest: controller.statusRequest,
            widget: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔹 Upload Area with Responsive Dashed Border
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
            
                      if (result != null) {
                        controller.selectedFile = File(result.files.single.path!);
                        controller.update();
                      }
                    },
                    child: CustomPaint(
                      painter: DashedBorderPainter(
                          color: AppColor.color9, scale: scale),
                      child: Container(
                        decoration:
                            BoxDecoration(
                              
                        color: AppColor.textfield,
                              borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImageassets.cloudicon,
                              height: 40,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              controller.selectedFile == null
                                  ? 'اختر الوظيفة من جهازك (PDF فقط)'
                                  : controller.selectedFile!.path.split('/').last,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            if (controller.selectedFile != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: IconButton(
                                  icon:
                                      const Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    controller.selectedFile = null;
                                    controller.update();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 25),
            
                  // 🔹 Description Field
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColor.textfield,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: controller.descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'أدخل تفاصيل الوظيفة...',
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
            
                  const SizedBox(height: 40),
            
                  // 🔹 Submit Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.selectedFile != null &&
                            controller.descriptionController.text.isNotEmpty) {
                          controller.uploadHomework(
                            controller.selectedFile!,
                            controller.descriptionController.text,
                          );
                        } else {
                         Get.snackbar(
              "خطأ", 
              "فشل في رفع الوظيفة",
              backgroundColor: Colors.white,
              colorText: Colors.black,
              borderRadius: 12,
              margin: const EdgeInsets.all(16),
              snackPosition: SnackPosition.BOTTOM,
              boxShadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              icon: const Icon(Icons.error, color: Colors.red),
            );
            
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: AppColor.color9,
                      ),
                      child: Text(
                        'إدراج الوظيفة',
                        style: AppTextStyles.cairo16semi
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double scale;

  DashedBorderPainter({
    required this.color,
    this.scale = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 24 * scale;
    double dashSpace = 12 * scale;
    double strokeWidth = 10 * scale;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create a rounded rectangle path
    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(8),
    );
    final Path path = Path()..addRRect(rRect);

    final Path dashedPath = Path();
    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double length = dashWidth;
        dashedPath.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
