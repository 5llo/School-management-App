import 'package:e_commerce/controller/parent/homeworkparentcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/homeworkmodel.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeworkParentPage extends StatelessWidget {
  final String childrenId;
  const HomeworkParentPage({super.key, required this.childrenId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Homeworkparentcontroller(childrenId));

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        title: const Text('وظائف الطالب'),
      ),
      body: GetBuilder<Homeworkparentcontroller>(
        builder: (_) {
          return Handlingdataview(
            statusrequest: controller.statusRequest,
            widget: RefreshIndicator(
              onRefresh: controller.getData,
              color: AppColor.color9,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.homeworks.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildHeader(controller.homeworks.length);
                  }
                  return _buildCard(controller.homeworks[index - 1], index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مرحباً بك ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.color2),
        ),
        const SizedBox(height: 4),
        Text(
          'هنا يمكنك متابعة وظائف ابنك اليومية بسهولة.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.assignment, color: AppColor.color9, size: 30),
              const SizedBox(width: 12),
              Text(
                'عدد الوظائف: $count',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCard(HomeworkModel hw, int index) {
    final date = _format(hw.createdAt);
    final fileName = hw.file.split('/').last;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 6),
          padding: const EdgeInsets.only(right: 16, left: 16, top: 30, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap:  () => _open(hw.file),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined, color: AppColor.color9, size: 25),
                    const SizedBox(width: 6),
                    Text("الملف:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.color9)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        fileName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ), 
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColor.color9, size: 25),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(hw.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[700])),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: AppColor.color9, size: 22),
                    const SizedBox(width: 6),
                    Text("التاريخ : $date", style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              
              ],
            ),
          ),
        ),
      
      ],
    );
  }

  String _format(String? s) {
    if (s == null || s.isEmpty) return '';
    try {
      final d = DateTime.parse(s);
      return DateFormat.yMMMd('ar').format(d);
    } catch (_) {
      return '';
    }
  }

  Future<void> _open(String path) async {
    final uri = Uri.parse("${AppLink.orginal}/$path");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("خطأ", "تعذّر فتح الملف.");
    }
  }
}
