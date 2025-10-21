// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';

class CustomContactWidget extends StatelessWidget {
  String name;
  String work;
   CustomContactWidget({
    super.key,
    required this.name,
    required this.work
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          CircleAvatar(radius: 25),
    
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(label: name, fontWeight: FontWeight.w600),
              CustomText(
                label: work,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
