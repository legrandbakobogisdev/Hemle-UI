import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/screens/findschool_screen.dart';

class FindSchoolScreen extends StatefulWidget {
  const FindSchoolScreen({super.key});

  @override
  State<FindSchoolScreen> createState() => _FindSchoolScreenState();
}

class _FindSchoolScreenState extends State<FindSchoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppbar(),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                label: 'home.find_school.title'.tr(),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),

              const SizedBox(height: 24),

              // Description
              CustomText(
                label: 'home.find_school.description'.tr(),
                fontSize: 16,
                color: AppColors.textSecondary,
              ),

              const SizedBox(height: 24),

              // Bouton Find School
              CustomButton(
                label: 'home.find_school.button'.tr(),
                fullWidth: true,
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => FindschoolScreen(),));
                },
              ),


              const SizedBox(height: 50),


              Image.asset(
                'assets/images/13.png'
              ),


            
            ],
          ),
        ),
      ),
    );
  }
}
