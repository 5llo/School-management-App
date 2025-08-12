import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Customweekschduale extends StatefulWidget {
  const Customweekschduale({super.key});

  @override
  State<Customweekschduale> createState() => _CustomweekschdualeState();
}

class _CustomweekschdualeState extends State<Customweekschduale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: AppColor.textfield,
        border: Border.all(width: 2, color: AppColor.color8.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 4),
                SvgPicture.asset(AppImageassets.tableicon, width: 23),
                const SizedBox(width: 4),
                Text(
                  "جدول الدوام اليومي",
                  style: AppTextStyles.cairo16.copyWith(color: AppColor.color2),
                ),
              ],
            ),
            const Divider(),
            _buildScheduleRow("الرياضيات",  "8:45", "8:00"),
            const SizedBox(height: 12),
            _buildScheduleRow("علوم", "9:30", "8:45"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "انقر لعرض التفاصيل بالكامل",
                  style: AppTextStyles.cairo12.copyWith(
                    color: AppColor.stroke,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String subject, String start, String end) {
    return Row(
      children: [
        SvgPicture.asset(AppImageassets.booksicon),
        const SizedBox(width: 4),
        Expanded(
          flex: 3,
          child: Text(
            subject,
            style: AppTextStyles.cairo14.copyWith(color: AppColor.color2),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "$start : $end",
            style: AppTextStyles.cairo14.copyWith(color: AppColor.color2),
            textAlign: TextAlign.center,
          ),
        ),
        SvgPicture.asset(AppImageassets.questionicon),
      ],
    );
  }
}
