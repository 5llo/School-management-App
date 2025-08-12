import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class Customcardprofile extends StatelessWidget {
  final String title;
  final String body;
  const Customcardprofile({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                    child: Container(
                      
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color:AppColor.color9,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  Column(
                        children: [
                          Text(title, style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(body, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
  }
}