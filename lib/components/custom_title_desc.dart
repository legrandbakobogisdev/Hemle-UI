// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';

class CustomTitleDesc extends StatelessWidget {
  String title;
  String? desc;
  double? fontsize;

  CustomTitleDesc({
    super.key,
    required this.title,
    this.desc,
    this.fontsize
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        CustomText(label: title, fontSize: fontsize ?? 14, fontWeight: FontWeight.w600),
        CustomText(label: desc ?? '', fontSize: 14, fontWeight: FontWeight.w500)
      ],
    );
  }
}