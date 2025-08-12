import 'package:e_commerce/controller/parent/postparentcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/view/screen/visitor/postdetails.dart';
import 'package:e_commerce/view/widget/visitor/custompostcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Postparentpage extends StatelessWidget {
  final String childrenId;

  Postparentpage({super.key, required this.childrenId});

  final TextEditingController searchController = TextEditingController();

  final List<Color> colorsList = const [
    Color(0xff54596E),
    Color(0xff5AA9E2),
    Color(0xffED89A6),
    Color(0xff84725A),
    Color.fromARGB(255, 245, 149, 23),
    Color.fromARGB(255, 19, 159, 0),
    Color.fromARGB(255, 17, 155, 170),
    Color.fromARGB(255, 213, 13, 67),
    Color.fromARGB(255, 173, 176, 128),
  ];

  @override
  Widget build(BuildContext context) {
    final Postparentcontroller controller = Get.put(Postparentcontroller(childrenId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('المنشورات'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppImageassets.backpageicon),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(() {
              final showClear = controller.searchText.value.isNotEmpty;
              return TextField(
                controller: searchController,
                onChanged: (value) => controller.searchPosts(value.trim()),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'ابحث عن منشور...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: showClear
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            searchController.clear();
                            controller.searchPosts('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColor.color7, width: 2),
                  ),
                ),
              );
            }),
          ),
        ),
        elevation: 6,
        backgroundColor: AppColor.color9,
      ),
      body: GetBuilder<Postparentcontroller>(
        builder: (controller) {
          return Handlingdataview(
            statusrequest: controller.statusrequest,
            widget: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Obx(() {
                final posts = controller.filteredData;

                if (posts.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.fetchPosts,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 100),
                        Center(
                          child: Text(
                            'لا توجد منشورات متاحة',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchPosts,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    child: ListView.separated(
                      itemCount: posts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final color = colorsList[index % colorsList.length];
                        return GestureDetector(
                          onTap: () => Get.to(() => Postdetails(data: post)),
                          child: Custompostcard(data: post, color: color),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
