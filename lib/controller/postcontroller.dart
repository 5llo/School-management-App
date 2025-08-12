import 'dart:ui';

import 'package:get/get.dart';

class Postcontroller extends GetxController{

List carddata=[
{
      'id': '00',
      'school': 'مدرسة الحكمة',
      'title': 'بحد عن منشور',
      'content': 'يسرأ في مدرسة الأمل أن تعلن عن صور برنامج القحص النهائي! نرجو من طلبنا الأعراء الاطلاع...',
      'isSpecial': false,
    },
    {
      'id': '00',
      'school': 'إدارة المدرسة',
      'title': 'النشر: إدارة المدرسة',
      'content': 'تعتبر هذه المنشورات خاصة للمدرسة:',
      'specialNote': 'تشير علمة اللجنة إلى المنشور بخصص لفئة معينة من الصفوف',
      'isSpecial': true,
    },
    {
      'id': '00',
      'school': 'مدرسة العمل',
      'title': 'النشر: مدرسة العمل',
      'content': 'يسرأ في مدرسة الأمل أن تعلن عن صور برنامج القحص النهائي! نرجو من طلبنا الأعراء الاطلاع...',
      'isSpecial': false,
    },

];


List colorslist=[
   const Color(0xff54596E),
   const Color(0xff5AA9E2),
   const Color(0xffED89A6),
   const Color(0xff84725A),
   const Color.fromARGB(255, 245, 149, 23),
   const Color.fromARGB(255, 19, 159, 0),
   const Color.fromARGB(255, 17, 155, 170),
   const Color.fromARGB(255, 213, 13, 67),
   const Color.fromARGB(255, 173, 176, 128),
];

}