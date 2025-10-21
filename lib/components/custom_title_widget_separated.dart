
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class CustomTitleWidgetSeparated extends StatelessWidget {
  String title;
  Widget widget;
  CustomTitleWidgetSeparated({
    super.key,
    required this.title,
    required this.widget
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label: title, fontWeight: FontWeight.w500,),
        
            widget
          ],
        ),
    
        Divider(thickness: 1, color: AppColors.border,)
      ],
    );
  }
}