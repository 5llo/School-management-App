import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class MyRefreshWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const MyRefreshWidget({Key? key, required this.onRefresh, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColor.color9,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
