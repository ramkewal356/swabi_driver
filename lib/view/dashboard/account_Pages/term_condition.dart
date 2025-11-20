import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/core/utils/dimensions.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
        appBarTitle: 'Term & Condition',
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
            
              SizedBox(
                width: AppDimension.getHeight(context) * .9,
                child: Text(
                    "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et "
                    "massa mi. Aliquam in hendrerit urna. Pellentesque sit amet "
                    "sapien fringilla, mattis ligula consectetur, ultrices. Lorem "
                    "ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. "
                    "Aliquam in hendrerit urna. Pellentesque sit amet sapien "
                    "fringilla, mattis ligula consectetur, ultrices.",
                    style: termCondition,
                    textAlign: TextAlign.left),
              ),
             
            ],
          ),
        ));

  }
}
