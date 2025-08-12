import 'package:e_commerce/controller/teacher/homeworkcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/data/model/homeworkmodel.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Homework extends StatelessWidget {
  const Homework({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeworkController controller = Get.put(HomeworkController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('الوظائف'),
      ),
      body: GetBuilder<HomeworkController>(
        builder: (_) {
          return RefreshIndicator(
            onRefresh: controller.getData,
            color: const Color.fromARGB(255, 0, 38, 128),
            child: Handlingdataview(
              statusrequest: controller.statusRequest,
              widget: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  // Add Button (Always visible)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRoute.addhomework);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'إدراج وظيفة',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.color9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Homework list or empty message
                  if (controller.homeworks.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Text(
                          'لا توجد وظائف حالياً',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )
                  else
                    ...controller.homeworks
                        .map((homework) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildHomeworkCard(homework),
                            ))
                        .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeworkCard(HomeworkModel homework) {
    print("Opening file: ${AppLink.orginal}/${homework.file}");

    final fileName = homework.file.split('/').last;
    final formattedDate =
        DateFormat.yMMMd('ar').format(DateTime.parse(homework.createdAt ?? ''));

    return Material(
      color: AppColor.textfield,
      borderRadius: BorderRadius.circular(14),
      elevation: 2.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
       onTap: () async {



  final url = Uri.parse("${AppLink.orginal}/${homework.file}");

  try {
    // جرب أولاً تفتح باستخدام تطبيق خارجي (مثل Google Drive أو قارئ PDF)
    bool launched = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      // fallback إلى الطريقة الافتراضية للنظام
      launched = await launchUrl(url, mode: LaunchMode.platformDefault);
    }

    if (!launched) {
      Get.snackbar("خطأ", "لم يتم فتح الملف، تأكد من وجود تطبيق قارئ PDF");
    }
  } catch (e) {
    print("Launch error: $e");
    Get.snackbar("خطأ", "حدث خطأ أثناء محاولة فتح الملف");
  }

}
,
        
        splashColor: AppColor.color9.withOpacity(0.1),
        highlightColor: AppColor.color9.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: AppColor.color9),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.open_in_new, color: AppColor.color9),
                      tooltip: "فتح الملف",
                      onPressed: ()  {
                      
                      }),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.description, size: 20, color: AppColor.color9),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      homework.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 18, color: AppColor.color9),
                  const SizedBox(width: 8),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> openInBrowser(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'لا يمكن فتح الرابط: $url';
  }
}
