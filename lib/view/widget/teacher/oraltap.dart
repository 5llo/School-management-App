import 'package:e_commerce/controller/teacher/studentsdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OralTab extends StatelessWidget {
  final Studentsdetailscontroller controller;

  const OralTab({super.key, required this.controller});

  Color _getGradeColor(double grade) {
    if (grade > 19) return const Color(0xFF800080);
    if (grade >= 15) return Colors.green.shade600;
    if (grade >= 10) return Colors.blue.shade600;
    if (grade >= 5) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Studentsdetailscontroller>(
      builder: (_) {
        return ListView.separated(
          itemCount: controller.subjects.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final subject = controller.subjects[index];
            final grade = subject.oralGrade;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject.subjectName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildControlButton(
                            icon: Icons.remove,
                            color: Colors.redAccent,
                            onPressed: () => controller.decrementOralGrade(index),
                            isActive: grade > 0,
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 44,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _getGradeColor(grade.toDouble()),
                            ),
                            child: Text(
                              '$grade/20',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                         _buildControlButton(
                            icon: Icons.add,
                            color: Colors.greenAccent,
                            onPressed: () => controller.incrementOralGrade(index),
                            isActive: grade < 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: isActive ? color.withOpacity(0.12) : Colors.grey.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: isActive ? onPressed : null,
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
