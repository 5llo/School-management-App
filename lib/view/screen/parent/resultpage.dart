import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/parent/resultcontroller.dart'; // User's external controller
import 'package:e_commerce/core/class/statusrequest.dart'; // User's external Statusrequest enum



class Resultpage extends StatelessWidget {
  final String childrenId;
  const Resultpage({super.key, required this.childrenId});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using Get.put as in your original code
    // Assuming Resultcontroller takes a String in its constructor for studentId
    Get.put(Resultcontroller(childrenId.toString()));

    return Scaffold(
      // AppBar styled to match the image
      appBar: AppBar(
       
      
            // Title
         title:   const Text(
              "النتائج الامتحانية",
              ),
            ),
            // Placeholder for menu icon (or remove if not needed)
       
      body: Directionality(
        textDirection: TextDirection.rtl, // Ensure RTL for the entire body content
        child: GetBuilder<Resultcontroller>(
          builder: (controller) {
            // Your original Handlingdataview usage
            return Handlingdataview(
              statusrequest: controller.statusrequest!, // Ensure statusrequest is non-null
              widget: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "نتائج الفصل الاول",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey, // Adjusted color to match image
                        ),
                      ),
                    ),
                  ),

                  // Table Headers
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100, // Light purple background
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Text("المادة", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14, color:AppColor.color9))),
                        Expanded(child: Text("الشفهي", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color:AppColor.color9))),
                        Expanded(child: Text("المذاكرة", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color:AppColor.color9))),
                        Expanded(child: Text("الامتحان", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color:AppColor.color9))),
                        Expanded(child: Text("الحضور", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color:AppColor.color9))),
                        Expanded(child: Text("المجموع", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color:AppColor.color9))),
                      ],
                    ),
                  ),

               
                  controller.data.isEmpty && controller.statusrequest == Statusrequest.success ?
                  Card(
                    margin: const EdgeInsets.only(top: 0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("لا توجد نتائج لعرضها.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                    ),
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Important for nested ListViews
                      itemCount: controller.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.data[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                            border: Border(
                              bottom: index == controller.data.length - 1
                                  ? BorderSide.none // No border for the last item
                                  : BorderSide(color: Colors.grey.shade200),
                            ),
                            // Apply bottom border radius only for the last item if it's the last in the list
                            borderRadius: index == controller.data.length - 1
                                ? const BorderRadius.vertical(bottom: Radius.circular(8))
                                : null,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Text(item['subject_name'].toString(),
  textAlign: TextAlign.center, style: const TextStyle(color: Colors.purple))),                              Expanded(
                                  child: Text(item['oral'].toString(),
                                      textAlign: TextAlign.center, style: const TextStyle(color: Colors.green))),
                              Expanded(
                                  child: Text(item['homework'].toString(),
                                      textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey))),
                              Expanded(
                                  child: Text(item['exam'].toString(),
                                                                        textAlign: TextAlign.center, style: const TextStyle(color: Colors.purple))),

                              Expanded(
                                  child: Text(item['attendance_grade'].toString(), // This should be 'النهائي'
                                      textAlign: TextAlign.center, style: const TextStyle(color: Colors.green))),
                              Expanded(
                                  child: Text(item['total_marks'].toString(), // This should be 'المجموع'
                                      textAlign: TextAlign.center, style: const TextStyle(color: Colors.purple))),
                            ],
                          ),
                        );
                      },
                    ),

                  // Final Total Marks section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 16), // Add top margin to separate from the list
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                        children: [
                          Text(
                            "المجموع النهائي:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 8), // Spacing
                          Text(
                            // Accessing finalTotalMarks directly from the controller
                            "% ${controller.finalTotalMarks ?? 'N/A'}", // Display only the total mark
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.color9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}