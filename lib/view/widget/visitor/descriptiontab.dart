import 'package:e_commerce/controller/addaddresscontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
     Mapcontroller controllerpage = Get.put(Mapcontroller());
    return Column(
      children: [
                    SizedBox(width: double.infinity,
                      child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,                        
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => index !=0
                                      ? const Icon(Icons.star,
                                          size: 20, color: Color(0xFFFFC107))
                                      : const Icon(Icons.star_border,
                                          size: 20, color: Color(0xFFFFC107)),
                                ),
                              ],
                                                       ),
                    ), 
                       const SizedBox(height: 12,),
                    SizedBox(
          height: 120,
          width: double.infinity,
    
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 4,
              childAspectRatio: 1.2, // تتحكم بعرض الكارد
            ),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on, size: 25, color: AppColor.color9),
                    SizedBox(height: 8),
                    Text("\$ 400", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.color9)),
                    SizedBox(height: 4),
                    Text("سنويا", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            },
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("شرح :",style: AppTextStyles.cairo20.copyWith(color: AppColor.color2,decoration: TextDecoration.none),),
              Text("""درسة الأمل هي مؤسسة تعليمية متكاملة تهدف إلى بناء جيل واعٍ ومبدع من خلال تقديم تعليم متميز يعتمد على أحدث الوسائل التعليمية والتقنيات الحديثة. تسعى المدرسة إلى تعزيز قيم التعاون، الإبداع، والتفوق لدى طلابها، مع التركيز على تطوير مهاراتهم الأكاديمية والاجتماعية.
          تُوفّر المدرسة بيئة تعليمية آمنة ومحفزة تُمكّن الطلاب من اكتشاف قدراتهم ومواهبهم، كما تُقدّم برامج وأنشطة متنوعة تشمل الجوانب العلمية، الفنية، والرياضية، لتلبية احتياجات جميع الطلاب.
          مدرسة الأمل تؤمن بأن التعليم هو أداة التغيير الأهم في بناء مستقبل أفضل، لذلك تُركّز على إشراك الطلاب وأولياء الأمور في عملية التعليم لتحقيق رؤية مشتركة قائمة على التميز والابتكار.""",style: AppTextStyles.cairo16.copyWith(color: AppColor.color2,decoration: TextDecoration.none),)
           
          , const SizedBox(height: 8,),
              Text("العنوان :",style: AppTextStyles.cairo20.copyWith(color: AppColor.color2,decoration: TextDecoration.none),),
              const Divider(),
    
    
            Container(
      decoration: BoxDecoration(
    border: Border.all(color: Colors.black12),
    borderRadius: BorderRadius.circular(32), // تعيين الزوايا هنا
      ),
      clipBehavior: Clip.antiAlias, // ضروري لقص المحتوى الداخلي
      child: ClipRRect(
    borderRadius: BorderRadius.circular(32), // تعيين نفس الزوايا هنا
    child: SizedBox(
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: controllerpage.kGooglePlex,
        onMapCreated: (GoogleMapController controllermap) {
          if (!controllerpage.completercontroller.isCompleted) {
            controllerpage.completercontroller.complete(controllermap);
          }
        },
      ),
    ),
      ),
    ),
    
            const SizedBox(height: 8,),
              Text("للتواصل :",style: AppTextStyles.cairo20.copyWith(color: AppColor.color2,decoration: TextDecoration.none),),
              const Divider(),
              const SizedBox(height: 16,),
                Row(
        children: [
         const Icon(
            Icons.phone_outlined,
            color: Colors.purple,
            size: 28,
          ),const SizedBox(width: 150,),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "محمد خليل",
                  style: AppTextStyles.cairo16Bold.copyWith(color: AppColor.color2,decoration: TextDecoration.none)
                ),
                const SizedBox(height: 4),
                const Text(
                  "0938794815",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,decoration: TextDecoration.none
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
           AppImageassets.profileimage, // بدّلها إذا عندك صورة محلية
            ),
          ),
         
    
     
        
        ],
      ),
            ],
          ),
        ),
       const SizedBox(height: 24,),
      ],
    );
  }
}
