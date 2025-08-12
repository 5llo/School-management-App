import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String titleappbar;
  final String? top;
  final void Function() onPressedIconSearch;
  final void Function() onPressedIconfavorite;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;

  const CustomAppBar({
    super.key,
    required this.titleappbar,
    required this.onPressedIconSearch,
    required this.onPressedIconfavorite,
    this.onChanged,
    this.mycontroller,
    this.top,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });

    widget.mycontroller?.addListener(() {
      setState(() {
        _hasText = widget.mycontroller?.text.isNotEmpty ?? false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _isFocused ? AppColor.color9 : Colors.grey.shade600;

    return Container(
      margin: EdgeInsets.only(top: widget.top != null ? 16 : 24),
      decoration: BoxDecoration(
        color: AppColor.textfield,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.mycontroller,
        onChanged: widget.onChanged,
        focusNode: _focusNode,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.titleappbar,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: IconButton(
            icon: Icon(Icons.search, size: 22, color: iconColor),
            onPressed: widget.onPressedIconSearch,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red), // ✅ X حمراء
                  onPressed: () {
                    widget.mycontroller?.clear();
                    widget.onChanged?.call('');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
