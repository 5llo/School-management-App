import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButtonAuth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return    Container(
    
              padding: const EdgeInsets.only(top: 24 ,bottom: 6),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                onPressed:onPressed,
                color: AppColor.color9,
                textColor: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(25),
             ),
                child:  Text(
                  text,
                  style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
            );
  }
}