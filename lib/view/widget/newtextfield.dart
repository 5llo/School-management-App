import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final VoidCallback? onSearchPressed;
  final String hintText;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSearchPressed,
    this.hintText = "ابحث هنا...",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // نفس ارتفاع الزر لتتساوى
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppColor.textfield,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.color9, width: 1.5),
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.search, color: Colors.grey.shade600),
            onPressed: onSearchPressed,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    controller.clear();
                    if (onChanged != null) onChanged!(""); // clear search
                  },
                )
              : null,
        ),
      ),
    );
  }
}
