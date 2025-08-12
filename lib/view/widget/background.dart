import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/imageassets.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final bool scroll;

  const BaseScaffold({super.key, required this.child, this.scroll = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImageassets.registerscreen,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        scroll
            ? SingleChildScrollView(child: child)
            : child,
      ],
    );
  }
}
