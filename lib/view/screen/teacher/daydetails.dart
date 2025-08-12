import 'package:e_commerce/controller/teacher/daydetailscontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Daydetails extends StatelessWidget {

  const Daydetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DayDetailsController());
    return GetBuilder<DayDetailsController>(
     
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text("تفاصيل اليوم"),
              leading:  IconButton(color: Colors.white, onPressed: () { Get.back() ;}, icon:const Icon(Icons.arrow_back_ios,size: 18,) , ),
            backgroundColor: AppColor.color9,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.file_upload_outlined),
                tooltip: "حفظ",
                onPressed: controller.saveAttendance, // يفترض أن تحفظ التعديلات
              ),
              const SizedBox(width: 8,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top session info card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColor.color9,
                        radius: 30,
                        child: Icon(Icons.menu_book_rounded,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "جلسة تعليمية اليوم 📚",
                              style: AppTextStyles.cairo16.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.color9,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              // DateFormat('EEEE, d MMMM yyyy – hh:mm a', 'ar')
                              //     .format(DateTime.now()),
                              "${controller.day} - ${controller.date} - الساعة ${controller.time}"
                              ,
                              style: AppTextStyles.cairo12
                                  .copyWith(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "اسم المادة : ${controller.subject}",
                              style: AppTextStyles.cairo14.copyWith(
                                color: Colors.grey[700],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Student List from controller.students
                Expanded(
                  child: Handlingdataview(
                    statusrequest: controller.statusrequest,
                    widget: controller.students.isEmpty
                        ? const Center(child: Text("لا يوجد طلاب"))
                        : ListView.separated(
                            itemCount: controller.students.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final student = controller.students[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(student.name!,
                                        style: AppTextStyles.cairo16.copyWith(
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("الدرجة الشفوية:",
                                            style: AppTextStyles.cairo14
                                                .copyWith(
                                                    color: Colors.grey[700])),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6),
                                          child: Row(
                                            children: [
                                              _buildIconButton(
                                                icon: Icons.add,
                                                color: Colors.green,
                                                onTap: () => controller
                                                    .incrementScore(index),
                                              ),
                                              const SizedBox(width: 12),
                                              Text('${student.oralGrade}',
                                                  style: AppTextStyles
                                                      .cairo16semi),
                                              const SizedBox(width: 12),
                                              _buildIconButton(
                                                icon: Icons.remove,
                                                color: Colors.redAccent,
                                                onTap: () => controller
                                                    .decrementScore(index),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text("حالة الطالب:",
                                        style: AppTextStyles.cairo14
                                            .copyWith(color: Colors.grey[700])),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 8,
                                      children: ['present', 'absent', 'excused', 'late']
                                          .map((status) {
                                        final isSelected =
                                            student.status == status;
                                        final chipColor = _statusColor(status);

                                        return ChoiceChip(
                                          checkmarkColor: AppColor.white,
                                          label: Text(_statusLabel(status)),
                                          selected: isSelected,
                                          onSelected: (_) =>
                                              controller.changeStatus(
                                                  index, status),
                                          selectedColor: chipColor,
                                          backgroundColor: AppColor.textfield,
                                           shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? chipColor : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
                                          labelStyle: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black87,
                                                
                                          ),
                                          elevation: 2,
                                          pressElevation: 6,
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'present':
        return 'حاضر';
      case 'absent':
        return 'غائب';
      case 'excused':
        return 'غ.مبرر';
      case 'late':
        return 'متأخر';
      default:
        return '';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'excused':
        return Colors.orange;
      case 'late':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
