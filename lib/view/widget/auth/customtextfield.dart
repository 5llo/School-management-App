import 'package:e_commerce/core/function/validinput.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
 TextEditingController? controllerfield;
  final String hinttext;
  final String labeltext;
  final String validatetype;
  final IconData icon;
  final bool ispass;
  final bool typenumber;

   Customtextfield({super.key,  this.controllerfield, required this.hinttext, required this.validatetype, required this.icon, required this.labeltext, required this.ispass, required this.typenumber});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(labeltext,
                          style: AppTextStyles.cairo14Bold),
                      const SizedBox(height: 4),
        TextFormField(
          keyboardType: typenumber?const TextInputType.numberWithOptions(decimal: true):TextInputType.emailAddress,
                            controller: controllerfield,
                            obscureText:ispass? true:false,
                            decoration: InputDecoration(
                              hintText: hinttext,
                              hintStyle: AppTextStyles.cairo14,
                              prefixIcon:  Icon(icon),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            validator: (val) => validInput(val!, 5, 50, validatetype),
                          ),
      ],
    );
  }
}