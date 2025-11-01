// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';

class CustomTitleWidget extends StatelessWidget {
  String title;
  Widget? widget;

  CustomTitleWidget({
    super.key,
    required this.title,
    this.widget
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(label: title, fontSize: 16, fontWeight: FontWeight.w600),
        
        widget ?? Container()
      ],
    );
  }
}