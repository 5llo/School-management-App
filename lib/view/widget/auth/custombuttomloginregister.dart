import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custombuttomloginregister extends StatelessWidget {
 final  void Function() onPressed;
 final String title;
  const Custombuttomloginregister({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(
                            
                            backgroundColor: AppColor.color9,
                            shape: RoundedRectangleBorder(
                              
                                borderRadius: BorderRadius.circular(8)),
                         //   padding: const EdgeInsets.symmetric(vertical: 14),
                           
                          
                          ),
                          onPressed:onPressed,
                          child:  Text(title,
                              style:
                                  const TextStyle(color: AppColor.white, fontSize: 18)),
                        ),
                      );
  }
}