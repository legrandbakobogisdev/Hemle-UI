// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class CustomHeader extends StatefulWidget {
  String title;
  String? desc;
  bool? hideshadow;
  Widget? actions;
  CustomHeader({
    super.key,
    required this.title,
    this.desc = '',
    this.actions,
    this.hideshadow = false,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        color: AppColors.background,
        boxShadow: widget.hideshadow == true
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.desc == ''
              ? CustomText(
                  label: widget.title,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      label: widget.title,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),

                    CustomText(
                            label: widget.desc ?? '',
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          )
                  ],
                ),

          widget.actions ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
