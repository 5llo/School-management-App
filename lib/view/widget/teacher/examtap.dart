import 'package:e_commerce/controller/teacher/studentsdetailscontroller.dart';
import 'package:e_commerce/data/model/StudentDetailsModel/studentsdetailsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamTab extends StatelessWidget {
  final Studentsdetailscontroller controller;

  const ExamTab({super.key, required this.controller});

  Color _getGradeColor(double grade, int max) {
    if (grade == max) return const Color(0xFF800080);
    final percent = grade / max;
    if (percent >= 0.9) return Colors.green.shade600;
    if (percent >= 0.7) return Colors.blue.shade600;
    if (percent >= 0.5) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Studentsdetailscontroller>(
      builder: (_) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.subjects.length,
          itemBuilder: (context, index) {
            final subject = controller.subjects[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.subjectName,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildGradeRow(index, 'homework', subject.homeworkGrade, 20, '📘 مذاكرة'),
                  const SizedBox(height: 10),
                  _buildGradeRow(index, 'exam', subject.examGrade, 50, '📝 امتحان'),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGradeRow(int index, String type, int grade, int max, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            _controlButton(
              icon: Icons.remove,
              color: Colors.redAccent,
              onPressed: () => controller.decrementExamGrade(index, type),
              isActive: grade > 0,
            ),
            const SizedBox(width: 8),
            Container(
              width: 48,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _getGradeColor(grade.toDouble(), max),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$grade/$max',
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _controlButton(
              icon: Icons.add,
              color: Colors.green,
              onPressed: () => controller.incrementExamGrade(index, type),
              isActive: grade < max,
            ),
          ],
        ),
      ],
    );
  }

  Widget _controlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: isActive ? color.withOpacity(0.15) : Colors.grey.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: isActive ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            size: 18,
            color: isActive ? color : Colors.grey,
          ),
        ),
      ),
    );
  }
}
