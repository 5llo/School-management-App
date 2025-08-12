import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController  mycontroller;
  final String? Function(String?) validator;
  final bool iskeyboardNumber;



  const CustomTextFormAuth({super.key, required this.hinttext, required this.labeltext, required this.iconData, required this.mycontroller, required this.validator, required this.iskeyboardNumber});
// 
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 24,bottom: 8),
      child: TextFormField(
         inputFormatters: [
    FilteringTextInputFormatter.deny(RegExp(r"\s")), // Prevent spaces
  ],
        keyboardType: iskeyboardNumber?const TextInputType.numberWithOptions(decimal: true):TextInputType.text ,
        validator: validator,
        controller: mycontroller,
                  decoration: InputDecoration(
                    
                    hintText:hinttext,
                    hintStyle: const TextStyle(fontSize: 14,),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 30),
                    label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      child:  Text(labeltext)),
                    suffixIcon:  Icon(iconData),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
      
                ),
    );
  }
}