import 'package:e_commerce/controller/parent/parentteacherevaluation.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/parent/ratingcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherRatingPage extends StatelessWidget {
  final String childrenId;

  const TeacherRatingPage({super.key, required this.childrenId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherRatingController>(
      init: TeacherRatingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: AppBar(
            title: const Text('تقييم المعلم'),
          ),
          body: Column(
            children: [
              /// Fixed Teacher Info (smaller card)
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(controller.teacherImage),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.teacherName,
                          style:  const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                       color:   AppColor.color9
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'مدرس الصف الخامس - علوم',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Scrollable Comments Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      /// Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'تقييمات أولياء الأمور',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          DropdownButton<String>(
                            value: 'الأحدث',
                            borderRadius: BorderRadius.circular(12),
                            items: ['الأحدث', 'الأقدم'].map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (val) {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// ListView of Ratings
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 12, bottom: 8),
                          itemCount: controller.ratings.length,
                          itemBuilder: (context, index) {
                            final rating = controller.ratings[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RatingCardWidget(data: rating),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Fixed Add Comment Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// Star Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < controller.selectedStars
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 30,
                          ),
                          onPressed: () => controller.setStars(index + 1),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),

                    /// Comment Input
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(controller.teacherImage),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              onChanged: controller.setComment,
                              decoration: const InputDecoration(
                                hintText: 'شارك رأيك حول أداء المعلم...',
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                              minLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.submitRating,
                        icon: const Icon(Icons.send_rounded,
                            color: Colors.white),
                        label: const Text(
                          "إرسال التقييم",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.color9,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
