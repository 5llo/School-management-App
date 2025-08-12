import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentsTab extends StatelessWidget {
  final List<String> imageUrls = [
    "it is very good",
    "it is very nice",
    "it is very nice",
    "it is very nice",
    "it is very nice",
    "it is very nice",
  ];

  CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 40),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: imageUrls.map((url) {
          return SizedBox(
            height: 150,
          
            child: Card(
              color: Colors.white,
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      child: Image.asset(
                        AppImageassets.profileimage,
                        width: 25,
                      ),
                    ),
                    title: const Text("محمد خليل"),
                    subtitle: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "مدرسة رائعة بكل معنى الكلمة مدرسة رائعة بكل معنى الكلمة"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImageassets.likeicon),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("1678"),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppImageassets.dislikeicon),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("22"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
