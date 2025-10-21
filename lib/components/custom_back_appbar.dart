import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class CustomBackAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomBackAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      title: CustomText(
        label: 'global.back'.tr(),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      centerTitle: false,
      titleSpacing: 0,
    );
  }
}
