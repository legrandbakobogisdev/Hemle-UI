// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class CustomTitleSeparateddata extends StatelessWidget {
  String title;
  final List<Map<String, String>> datas;
  String data_key;
  String data_value;

  CustomTitleSeparateddata({
    super.key,
    required this.title,
    required this.datas,
    required this.data_key,
    required this.data_value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        CustomText(label: title, fontSize: 14, fontWeight: FontWeight.w600),


        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: datas.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = datas[index];

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: data[data_key]!,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),

                    CustomText(
                      label: data[data_value]!,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                Divider(color: AppColors.border),
              ],
            );
          },
        ),
      ],
    );
  }
}
