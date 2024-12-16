import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';

class CustomTextFeildWidget extends StatefulWidget {
  const CustomTextFeildWidget({super.key});

  @override
  State<CustomTextFeildWidget> createState() => _CustomTextFeildWidgetState();
}

class _CustomTextFeildWidgetState extends State<CustomTextFeildWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        width: AppDimension.getWidth(context)*.9,
        decoration: BoxDecoration(
            border: Border.all(color: naturalGreyColor),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.only(top: 5),
            prefixIcon: const Icon(Icons.email_outlined),

            suffixIcon: IconButton(
            onPressed: () {
              
            },
              icon: const Icon(Icons.remove_red_eye),
            ),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
        ),
      ),
    );
  }
}
