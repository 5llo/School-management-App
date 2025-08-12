import 'package:e_commerce/controller/teacher/studentsdetailscontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/widget/teacher/attendance.dart';
import 'package:e_commerce/view/widget/teacher/examtap.dart';
import 'package:e_commerce/view/widget/teacher/oraltap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetailsPage extends StatelessWidget {
  const StudentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Studentsdetailscontroller>(
      init: Studentsdetailscontroller(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('تفاصيل الطالب'),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios, size: 18),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.file_upload_outlined),
                  tooltip: "حفظ",
                  onPressed: controller.saveStudentMarks,
                ),
                const SizedBox(width: 8),
              ],
            ),
            backgroundColor: Colors.white,
            body: Handlingdataview(
              statusrequest: controller.statusrequest,
              widget: Column(
                children: [
                  _buildStudentCard(controller),
                  _buildTabBar(controller),
                  const SizedBox(height: 10),
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChanged,
                      children: [
                        const AttendanceTab(),
                        OralTab(controller: controller),
                        ExamTab(controller: controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStudentCard(Studentsdetailscontroller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImageassets.profileimage,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.student.name,
                        style: AppTextStyles.cairo14Bold.copyWith(fontSize: 17)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person_outlined, size: 18, color: AppColor.color9),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text('اسم الاب : ${controller.student.parentName}',
                              style: AppTextStyles.cairo14
                                  .copyWith(fontSize: 14, color: Colors.grey[700])),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.phone_android, size: 18, color: AppColor.color9),
                        const SizedBox(width: 6),
                        Text('رقم الهاتف : ', style: AppTextStyles.cairo14),
                        GestureDetector(
                          onTap: () async {
                            final Uri phoneUri =
                                Uri(scheme: 'tel', path: controller.student.parentPhone);
                            if (await canLaunchUrl(phoneUri)) {
                              await launchUrl(phoneUri);
                            }
                          },
                          child: Text(
                            controller.student.parentPhone,
                            style: AppTextStyles.cairo14.copyWith(
                              color: AppColor.color9,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.message_rounded),
                color: AppColor.color9,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(Studentsdetailscontroller controller) {
    final tabs = ["حضور", "شفهي", "مذاكرة و امتحان"];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final selected = controller.selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? AppColor.color9.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      tabs[index],
                      style: AppTextStyles.cairo14Bold.copyWith(
                        color: selected ? AppColor.color9 : AppColor.color2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 3,
                      width: selected ? 40 : 0,
                      decoration: BoxDecoration(
                        color: AppColor.color9,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
