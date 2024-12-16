import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class CustomCheckBox extends StatelessWidget {
  final VoidCallback onTap;
  final String contect;
  final bool value;
  const CustomCheckBox({super.key,
    required this.onTap,
    required this.contect,
    required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 20,
              width: 20,
            decoration: BoxDecoration(
              color: value? Colors.black:Colors.transparent,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.black,width: 2.5),
            ),
            child: value?const Icon(Icons.check,color: Colors.white,size: 15,):null,
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(contect,style: titleTextStyle,),
        )
      ],
    );
  }
}
