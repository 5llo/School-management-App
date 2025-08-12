import 'package:e_commerce/controller/teacher/studentsbigdetailscontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/core/function/RefreshIndicator.dart';
import 'package:e_commerce/view/widget/newtextfield.dart';
import 'package:e_commerce/view/widget/teacher/studentcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentPage extends StatelessWidget {
  StudentPage({super.key});
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> filters = [
    {"label": "الكل", "value": "none"},
    {"label": "أعلى العلامات النهائية", "value": "final"},
    {"label": "أعلى الشفهي", "value": "oral"},
    {"label": "أعلى الامتحان", "value": "exam"},
    {"label": "أعلى الحضور", "value": "present"},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Studentsbigdetailscontroller>(
      init: Studentsbigdetailscontroller(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('معدلات الطلاب'),
              backgroundColor: AppColor.color9,
            ),
            body: Handlingdataview(
              statusrequest: controller.statusrequest,
              widget: MyRefreshWidget(
                onRefresh: () async{await  controller.getData(); },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomSearchField(
                              controller: searchController,
                              hintText: 'ابحث عن طالب',
                              onChanged: (value) => controller.updateSearch(value),
                              onSearchPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                             Get.toNamed(AppRoute.setmarkspage);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.color9,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                elevation: 0,
                              ),
                              child: const Text(
                                'تقرير العلامات',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // باقي الصفحة (اختيار المادة، التصفية، قائمة الطلاب) كما كانت
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
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
                                      child: Text(material),
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
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColor.textfield,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.gradeFilter,
                                icon: const Icon(Icons.filter_list),
                                hint: const Text('ترتيب حسب'),
                                items: filters.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['value'],
                                    child: Text(item['label']!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.changeGradeFilter(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    Expanded(
                      child: controller.filteredStudents.isEmpty
                          ? const Center(child: Text("لا يوجد طلاب"))
                          : ListView.builder(
                              itemCount: controller.filteredStudents.length,
                              itemBuilder: (context, index) {
                                final student = controller.filteredStudents[index];
                                return StudentCard(
                                  student: student,
                                  selectedMaterial: controller.selectedMaterial,
                                  controller: controller,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
