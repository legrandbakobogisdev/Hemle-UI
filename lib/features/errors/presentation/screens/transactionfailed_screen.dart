import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class TransactionfailedScreen extends StatelessWidget {
  const TransactionfailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SvgPicture.asset(
                  "assets/images/50.svg",
                  width: 247,
                  height: 199,
                  fit: BoxFit.cover,
                ),
                Column(
                  spacing: 8,
                  children: [
                    CustomText(
                      label: 'error.transactionfailed.title'.tr(),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),

                    CustomText(
                      label: 'error.transactionfailed.desc'.tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: CustomButton(
              fullWidth: true,
              onPressed: () {},
              label: 'global.backtohome'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
