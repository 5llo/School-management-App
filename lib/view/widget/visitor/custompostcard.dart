import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Custompostcard extends StatelessWidget {
  final Color? color;
  final Map? data;
  final void Function()? onTap;

  const Custompostcard({super.key, this.color, this.onTap, this.data});

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
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppImageassets.bookicontwo,
                                width: 35,
                              ),
                              const SizedBox(width: 8),
                              const Text("الناشر :", style: AppTextStyles.cairo16),
                              const SizedBox(width: 8),
                              Text(
                                "${data!["school"]}",
                                style: AppTextStyles.cairo16Bold.copyWith(color: AppColor.color9),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ...List.generate(
                                4,
                                (index) => index == 3
                                    ? const Icon(Icons.star, size: 20, color: Color(0xFFFFC107))
                                    : const Icon(Icons.star_border, size: 20, color: Color(0xFFFFC107)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Post Content
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "${data!["post"].toString().substring(0, data!["post"].toString().length > 100 ? 100 : data!["post"].toString().length)}...",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.access_time, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime("${data!["time"]}"),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      )
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

  String _formatTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat.jm('ar').format(dateTime);
    } catch (_) {
      return '';
    }
  }
}
