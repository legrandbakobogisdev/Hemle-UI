// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class Customformsection extends StatefulWidget {
  String title;
  bool isRequired;
  Widget input;

   Customformsection({super.key, required this.title, required this.isRequired, required this.input});

  @override
  State<Customformsection> createState() => _CustomformsectionState();
}

class _CustomformsectionState extends State<Customformsection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
      children: [
        Wrap(
          children: [
            if(widget.isRequired)
            CustomText(label: '*', fontWeight: FontWeight.w600, color: AppColors.primary,) ,
            CustomText(label: widget.title, fontSize: 15, fontWeight: FontWeight.w600,),
          ],
        ),

        widget.input
      ],
    );
  }
}