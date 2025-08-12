import 'dart:ui';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SchoolController extends GetxController {
  List<Map<String, dynamic>> schools = [
    {
      'title': 'مدرسة الأمل',
      'items': ['عدد الطلاب : 2345', 'عدد المعلمين : 123',],
      'color': const Color.fromARGB(179, 45, 119, 109),
    },
    {
      'title': 'مدرسة النور',
      'items': ['(دعم)', '(إجراءات العمل)'],
      'color': const Color.fromARGB(179, 167, 49, 49),
    },
    {
      'title': 'مدرسة الحب',
      'items': ['(دعم)', '(إجراءات العمل)'],
      'color': const Color.fromARGB(255, 27, 27, 164),
    },
    {
      'title': 'مدرسة العلم',
      'items': ['(دعم)', '(إجراءات العمل)'],
      'color': const Color.fromARGB(255, 47, 149, 162),
    },
    {
      'title': 'مدرسة الرشيد ',
      'items': ['(دعم)', '(إجراءات العمل)'],
      'color': const Color.fromARGB(255, 30, 110, 14),
    },
    {
      'title': 'مدرسة الأندلس ',
      'items': ['(دعم)', '(إجراءات العمل)'],
      'color': const Color.fromARGB(255, 127, 144, 16),
    },
  ];
}