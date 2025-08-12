import 'package:e_commerce/controller/teacher/studentsbigdetailscontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetMarkPage extends StatelessWidget {
  SetMarkPage({Key? key}) : super(key: key);
  final Studentsbigdetailscontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل العلامات"),
          backgroundColor: AppColor.color9,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getData();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GetBuilder<Studentsbigdetailscontroller>(
              builder: (controller) {
                return Handlingdataview(
                  statusrequest: controller.statusrequest,
                  widget: Column(
                    children: [
                      // Dropdown + Save
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColor.textfield,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.selectedMaterial,
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  items: controller.subjectsNames.map((material) {
                                    return DropdownMenuItem<String>(
                                      value: material,
                                      child: Text(
                                        material,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.changeMaterial(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save, size: 18, color: Colors.white),
                              label: const Text("حفظ", style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                bool confirm = await showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text("تأكيد الحفظ"),
                                        content: const Text("هل أنت متأكد من حفظ جميع العلامات؟"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text("إلغاء"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: const Text("نعم"),
                                          ),
                                        ],
                                      ),
                                    ) ??
                                    false;

                                if (confirm) {
                                  await controller.submitAllGrades();
                                  await controller.getData();
                                  Get.back();

                                  Get.snackbar(
                                    "",
                                    "",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppColor.white,
                                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(16),
                                    borderRadius: 16,
                                    boxShadows: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    titleText: const Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Colors.green, size: 24),
                                        SizedBox(width: 10),
                                        Text(
                                          "تم الحفظ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    messageText: const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        "تم حفظ حالة الطلاب بنجاح ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    animationDuration: const Duration(milliseconds: 900),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.color9,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Students list
                      Expanded(
                        child: controller.filteredStudents.isEmpty
                            ? const Center(child: Text("لا يوجد طلاب"))
                            : ListView.separated(
                                itemCount: controller.filteredStudents.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final student = controller.filteredStudents[index];
                                  final subject = controller.subjectsNames.contains(controller.selectedMaterial)
                                      ? student.subjects.firstWhere(
                                          (s) => s.subjectName == controller.selectedMaterial,
                                          orElse: () => student.subjects.first,
                                        )
                                      : student.subjects.first;

                                  return Card(
                                    color: AppColor.textfield,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 24,
                                                backgroundImage: AssetImage(AppImageassets.profileimage),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  student.name,
                                                  style: AppTextStyles.cairo16semi.copyWith(fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller.resetStudentGrades(student.id);
                                                },
                                                child: const Text("إعادة تعيين الكل"),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),

                                          // Sliders with reset per grade
                                         GradeSliderWithReset(
  label: "الشفهي",
  max: 20,
  color: Colors.deepPurple,
  value: subject.oralGrade.toDouble(),
  icon: Icons.record_voice_over, // microphone icon for oral
  onChanged: (val) {
    subject.oralGrade = val.toInt();
    controller.update();
  },
  onReset: () {
    final originalGrade = controller.getOriginalGrade(student.id, subject.subjectName, "oralGrade");
    subject.oralGrade = originalGrade;
    controller.update();
  },
),

GradeSliderWithReset(
  label: "الامتحان",
  max: 50,
  color: Colors.red,
  value: subject.examGrade.toDouble(),
  icon: Icons.edit_note, // note icon for exam
  onChanged: (val) {
    subject.examGrade = val.toInt();
    controller.update();
  },
  onReset: () {
    final originalGrade = controller.getOriginalGrade(student.id, subject.subjectName, "examGrade");
    subject.examGrade = originalGrade;
    controller.update();
  },
),

GradeSliderWithReset(
  label: "الوظائف",
  max: 20,
  color: Colors.blue,
  value: subject.homeworkGrade.toDouble(),
  icon: Icons.assignment, // clipboard icon for homework
  onChanged: (val) {
    subject.homeworkGrade = val.toInt();
    controller.update();
  },
  onReset: () {
    final originalGrade = controller.getOriginalGrade(student.id, subject.subjectName, "homeworkGrade");
    subject.homeworkGrade = originalGrade;
    controller.update();
  },
),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
class GradeSliderWithReset extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final Color color;
  final ValueChanged<double> onChanged;
  final VoidCallback onReset;
  final IconData icon; // New icon param

  const GradeSliderWithReset({
    Key? key,
    required this.label,
    required this.value,
    required this.max,
    required this.color,
    required this.onChanged,
    required this.onReset,
    required this.icon, // required now
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.refresh, color: color, size: 20),
              tooltip: "إعادة تعيين $label",
              onPressed: onReset,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: 0,
                max: max,
                divisions: max.toInt(),
                activeColor: color,
                label: value.toInt().toString(),
                onChanged: onChanged,
              ),
            ),
            Container(
              width: 40,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: color.darken(0.3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
