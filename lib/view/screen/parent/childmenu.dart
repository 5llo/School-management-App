import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/parent/studentmenucontroller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/core/services/services.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:e_commerce/view/screen/parent/BusTrackingScreen.dart';
import 'package:e_commerce/view/screen/parent/attendanceparentpage.dart';
import 'package:e_commerce/view/screen/parent/chatscreen.dart';
import 'package:e_commerce/view/screen/parent/examsceduleparent.dart';
import 'package:e_commerce/view/screen/parent/homeworkparentpage.dart';
import 'package:e_commerce/view/screen/parent/postparentpage.dart';
import 'package:e_commerce/view/screen/parent/resultpage.dart';
import 'package:e_commerce/view/screen/parent/schoolevaluation.dart';
import 'package:e_commerce/view/screen/parent/studyweekparentschedule.dart';
import 'package:e_commerce/view/screen/parent/teacherevaluation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Childmenu extends StatelessWidget {
  const Childmenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Studentmenucontroller>();

    final children_id = Get.arguments['children_id'];
    final children_name = Get.arguments['children_name'];
    final calss = Get.arguments['calss'];
    final division = Get.arguments['division'];
    final parent_id = Get.arguments['parent_id'];
    final parent_name = Get.arguments['parent_name'];
    final teacher_id = Get.arguments['teacher_id'];
    final teacher_name = Get.arguments['teacher_name'];
    final driverId = Get.arguments['driver_id'];
    final schoolLat = Get.arguments['schoolLat'];
    final schoolLong = Get.arguments['schoolLong'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل الطالب"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppImageassets.backpageicon, width: 10),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColor.textfield),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 121, 117, 117)
                        .withOpacity(0.15),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("مرحبا",
                          style: AppTextStyles.cairo14
                              .copyWith(color: AppColor.color9)),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(children_name,
                            style: AppTextStyles.cairo16Bold
                                .copyWith(color: AppColor.color9)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(division, style: AppTextStyles.cairo14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.color8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: const EdgeInsets.only(top: 24, left: 8),
                        padding: const EdgeInsets.all(8),
                        child: Text(calss,
                            style: AppTextStyles.cairo14Bold
                                .copyWith(color: AppColor.white)),
                      ),
                      SvgPicture.asset(AppImageassets.parentbigstudent),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.4,
                ),
                itemCount: controller.mainlista.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = controller.mainlista[index];
                  return InkWell(
                    onTap: () async {
                      switch (item['id']) {
                        case 'chat_teacher':
                          final parentId = parent_id.toString();
                          final parentName = parent_name;
                          const currentUserRole = "parent";
                          final teacherId = teacher_id.toString();
                          final teacherName = teacher_name;

                          final firestore = FirebaseFirestore.instance;
                          final ids = [parentId, teacherId]..sort();
                          final chatId = ids.join("_");

                          final chatDoc =
                              firestore.collection("chats").doc(chatId);
                          final chatSnapshot = await chatDoc.get();

                          if (!chatSnapshot.exists) {
                            await chatDoc.set({
                              "participants": [
                                {
                                  "id": parentId,
                                  "name": parentName,
                                  "role": "parent"
                                },
                                {
                                  "id": teacherId,
                                  "name": teacherName,
                                  "role": "teacher"
                                },
                              ],
                              "participantIds": [parentId, teacherId],
                              "lastMessage": "",
                              "updatedAt": FieldValue.serverTimestamp(),
                            });
                          }

                          Get.to(() => ChatScreen(
                                receiverRole: "teacher",
                                chatId: chatId,
                                currentUserId: parentId,
                                currentUserName: parentName,
                                currentUserRole: currentUserRole,
                                receiverId: teacherId,
                                receiverName: teacherName,
                              ));
                          break;
                        case 'bus_tracking':
                          Get.to(() => BusTrackingScreen(
                                driverId: driverId.toString(),
                                schoolLat:
                                    double.tryParse(schoolLat.toString()),
                                schoolLong:
                                    double.tryParse(schoolLong.toString()),
                              ));
                          break;

                        case 'exam_results':
                          Get.to(() => Resultpage(
                                childrenId: children_id.toString(),
                              ));
                          break;

                        case 'homework':
                          Get.to(() => HomeworkParentPage(
                                childrenId: children_id.toString(),
                              ));
                          break;

                        case 'study_schedule':
                          Get.to(() => Studyweekparentschedule(
                                childrenId: children_id.toString(),
                                //    childrenName: children_name.toString(),
                              ));
                          break;

                        case 'exam_schedule':
                          Get.to(() => Examsceduleparent(
                                childrenId: children_id.toString(),
                                //    childrenName: children_name.toString(),
                              ));
                          break;

                        case 'attendance':
Get.to(() => const Attendanceparentpage(), arguments: {
  "childrenId": children_id.toString(),
});
                          break;

                        case 'posts':
                          Get.to(() => Postparentpage(
                                childrenId: children_id.toString(),
                                //    childrenName: children_name.toString(),
                              ));
                          break;



                        case 'evaluate_teacher':
                          Get.to(() => TeacherRatingPage(
                                childrenId: children_id.toString(),
                                //    childrenName: children_name.toString(),
                              ));
                          break;
                        case 'evaluate_school':
                          Get.to(() => SchoolRatingPage(
                                childrenId: children_id.toString(),
                                //    childrenName: children_name.toString(),
                              ));
                          break;

                        default:
                          // يمكنك إضافة باقي الحالات هنا لاحقًا حسب الحاجة
                          break;
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(item["icon"]),
                          const SizedBox(height: 8),
                          Text(item["title"], style: AppTextStyles.cairo16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
