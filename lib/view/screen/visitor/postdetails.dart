import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/imageassets.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Postdetails extends StatelessWidget {
  final Map? data;

  const Postdetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
       
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(AppImageassets.backpageicon),
        ),
        title: const Text(
          "تفاصيل المنشور",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Header Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppImageassets.booksicon, width: 32),
                    const SizedBox(width: 8),
                    const Text("الناشر :", style: AppTextStyles.cairo16),
                    const SizedBox(width: 6),
                    Text(
                      "${data!["school"]}",
                      style: AppTextStyles.cairo16Bold.copyWith(color: AppColor.color9),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(
                    4,
                    (index) => index == 3
                        ? const Icon(Icons.star, size: 20, color: Color(0xFFFFC107))
                        : const Icon(Icons.star_border, size: 20, color: Color(0xFFFFC107)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Post Content
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: _buildPostText("${data!["post"]}"),
            ),

            const SizedBox(height: 24),

            // Time
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.access_time, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  _formatTime("${data!["time"]}"),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Convert normal string with URL to RichText with clickable blue URLs
  Widget _buildPostText(String text) {
final regex = RegExp(
  r'(https?:\/\/[^\s]+)|(www\.[^\s]+)',
  caseSensitive: false,
);

    final spans = <TextSpan>[];
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;
    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final url = text.substring(match.start, match.end);
      final fixedUrl = url.startsWith('http') ? url : 'https://$url';

      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(fixedUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                Get.snackbar("خطأ", "تعذر فتح الرابط.");
              }
            },
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return SelectableText.rich(
      TextSpan(
        style: AppTextStyles.cairo16.copyWith(color: AppColor.color2),
        children: spans,
      ),
    );
  }

  /// Format time to Arabic display like: ٨:١١ ص - ١٥ يونيو ٢٠٢٥
  String _formatTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final time = DateFormat.jm('ar').format(dateTime); // ٨:١١ م
      final date = DateFormat.yMMMMd('ar').format(dateTime); // ١٥ يونيو ٢٠٢٥
      return "$time - $date";
    } catch (_) {
      return '';
    }
  }
}
