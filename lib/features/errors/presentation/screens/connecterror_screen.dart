import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class ConnecterrorScreen extends StatelessWidget {
  const ConnecterrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset('assets/images/10.svg'),
            CustomText(
              label: 'global.refresh'.tr(),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ],
        ),
        ),
        backgroundColor: AppColors.background,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          SvgPicture.asset(
            "assets/images/27.svg",
            width: 247,
            height: 199,
            fit: BoxFit.cover,
          ),
          CustomText(
            label: 'error.connect.title'.tr(),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      )
    );
  }
}
