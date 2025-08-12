
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SchoolSquareCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final void Function()? onTap;

  const SchoolSquareCard({
    super.key,
    required this.title,
    required this.items,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: SizedBox(
          height: 160,
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                            radius: 33,
                            backgroundColor: AppColor.color9,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage(AppImageassets.profileimage),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            title,
                            style: AppTextStyles.cairo16Bold.copyWith(color: AppColor.color9)
                          ), const SizedBox(width: 4,), SvgPicture.asset(
                                AppImageassets.booksicon,
                                width: 25,
                              ),
                            ],
                          ),

                           Container(
                            height: 64,
                            alignment: Alignment.topLeft,
                             child: Row(
                                                       
                              children: [
                                ...List.generate(
                                  4,
                                  (index) => index !=0
                                      ? const Icon(Icons.star,
                                          size: 20, color: Color(0xFFFFC107))
                                      : const Icon(Icons.star_border,
                                          size: 20, color: Color(0xFFFFC107)),
                                ),
                              ],
                                                       ),
                           )
                        ],
                      ),
                      const SizedBox(height: 12),

                   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                 
                    children: [
                        Row(
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0,left: 3),
                           child: SvgPicture.asset(AppImageassets.pointicon,width: 7,color: AppColor.color9,),
                        ),
                         const Text("عدد الطلاب : "),
                         Text("4234",style: AppTextStyles.cairo14Bold.copyWith(color: AppColor.color9),),
                       ],
                     ),

                     Row(
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0,left: 3),
                         child: SvgPicture.asset(AppImageassets.pointicon,width: 7,color: AppColor.color9,),
                        ),
                         const Text("عدد المعلمين : "),
                         Text("4234",style: AppTextStyles.cairo14Bold.copyWith(color: AppColor.color9),),
                       ],
                     )
                    ],
                   ),
                   const SizedBox(height: 12,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0,left: 3),
                          child: SvgPicture.asset(AppImageassets.pointicon,width: 7,color: AppColor.color9,),
                        ),
                         const Text("حمص -شارع الدبلان"),
                      
                       ],
                     ),
                    
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
