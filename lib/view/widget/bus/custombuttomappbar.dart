import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Custombuttomappbar extends StatelessWidget {
  final void Function() onPressed;
  final String textbutton;
  final String  icondata;
  final bool active;
  const Custombuttomappbar(
      {super.key,
      required this.onPressed,
      required this.textbutton,
      required this.icondata,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
  splashColor: Colors.transparent,
  onPressed: onPressed,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // ✅ الحد من الأعلى (يظهر فقط إذا active = true)
      if (active)
        Container(
          height: 3,
          width: 48,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColor.color9,
                width: 2,
              ),
            ),
          ),
        ),

      // ✅ مسافة بين الحد والأيقونة
      if (active) const SizedBox(height: 6),

      // ✅ الأيقونة بصيغة SVG
      SvgPicture.asset(width: 25,
        icondata,
        color: active ? AppColor.color9 : Colors.grey,
      ),

      // ✅ النص
      Text(
        textbutton,
        style: TextStyle(
          color: active ? AppColor.color9 : Colors.grey,fontSize: 12
        ),
      ),
    ],
  ),
);
  }
}
