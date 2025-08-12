import 'package:e_commerce/controller/teacher/studentsbigdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/data/model/StudentDetailsModel/studentsdetailsmodel.dart';

class StudentCard extends StatelessWidget {
  final StudentTopDetailsModel student;
  final String selectedMaterial;
final Studentsbigdetailscontroller controller;
  const StudentCard({
    super.key,
    required this.student,
    required this.selectedMaterial, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final subject = student.subjects.firstWhere(
      (s) => s.subjectName == selectedMaterial,
      orElse: () => Subject(
        subjectName: "",
        oralGrade: 0,
        homeworkGrade: 0,
        examGrade: 0,
        attendancegrade: 0,
        numberofpresent: 0,
        numberofabsent: 0,
        numberoflate: 0,
        numberofearlyleave: 0, subjectId: 0,
      ),
    );

    int totalMark = subject.oralGrade +
        subject.homeworkGrade +
        subject.examGrade +
        subject.attendancegrade;

    return InkWell(

onTap: () async {
  final result = await Get.toNamed(
    AppRoute.teacherstudentsdetials,
    arguments: {
      'student': student,
    },
  );

  if (result == true) {
    controller.getData(); // 👈 أعد تحميل البيانات من الـ API
  }
},




  
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 14, left: 14, bottom: 14),
              child: Row(
                children: [
                  // Profile section
                  Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(AppImageassets.profileimage),
                        radius: 28,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: Text(
                          student.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  // Details section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                       SizedBox(
  height: 200, // زيادة بسيطة
  child: GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 3.2, // تقليل النسبة لتكبير الصندوق رأسيًا
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      _infoTile("الشفهي", subject.oralGrade, Icons.mic, Colors.indigo),
      _infoTile("الوظائف", subject.homeworkGrade, Icons.task_alt, Colors.orange),
      _infoTile("الامتحان", subject.examGrade, Icons.edit, Colors.deepPurple),
      _infoTile("الحضور", subject.attendancegrade, Icons.access_time, Colors.teal),
      _infoTile("عدد الحضور", subject.numberofpresent, Icons.check, Colors.green),
      _infoTile("التأخير", subject.numberoflate, Icons.timer, Colors.amber.shade800),
      _infoTile("عدد الغياب", subject.numberofabsent, Icons.close, Colors.redAccent),
      _infoTile("مبرر", subject.numberofearlyleave, Icons.logout, Colors.blueGrey),
    ],
  ),
),


                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.grade, size: 16, color: Colors.purple),
                            const SizedBox(width: 6),
                            Text(
                              "العلامة النهائية: 100 / $totalMark",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Subject name and icon at top-right
            Positioned(
              top: 10,
              right: 16,
              child: Row(
                children: [
                  SvgPicture.asset(AppImageassets.booksicon, width: 20),
                  const SizedBox(width: 6),
                  Text(
                    subject.subjectName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.color9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, int value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.only(right: 4, bottom
      : 4,top: 4,left: 0),
      constraints: const BoxConstraints(minWidth: 110),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              "$label: $value",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
