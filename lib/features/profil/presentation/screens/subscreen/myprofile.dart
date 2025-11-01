import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/applications/presentation/screens/applications_screen.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/editprofile.dart';
import 'package:hemle/features/tuition/presentation/screens/tuition_screen.dart';

class Myprofile extends StatelessWidget {
  const Myprofile({super.key});

  @override
  Widget build(BuildContext context) {

   const textColor = Color(0xFF6A737D);

  // Méthode pour créer une ligne d'information avec icône
  Widget buildInfoRow(Widget icon, String text, bool darkColor) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 6),
        CustomText(
          label: text,
          fontSize: 14,
          color: darkColor == true ? null : textColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

    Widget buildInfoRowCustom(Widget icon, String text, bool darkColor, VoidCallback onPressed) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 6),
                  CustomText(
                    label: text,
                    fontSize: 14,
                    color: darkColor == true ? null : textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  Spacer(),
                  CupertinoListTileChevron()
                ],
              ),

              Divider()
            ],
          ),
        ),

              
      ],
    );
  }

    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                CircleAvatar(radius: 20),
            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'Chantal Fobi',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
            
                    CustomText(
                      label: 'home.appbar.nochild'.tr(),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
            
                Spacer(),
            
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  sizeStyle: CupertinoButtonSize.small,
                  child: CustomText(
                    label: 'global.modify'.tr(),
                    color: AppColors.black,
                    fontSize: 12,
                  ),
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => Editprofile(),));
                  },
                ),
              ],
            ),


            _buildSection(
              'global.contact'.tr(),
              Column(
                spacing: 15,
                children: [
                  buildInfoRow(SvgPicture.asset('assets/images/85.svg'), '+237 698 024 135', true),
                  buildInfoRow(SvgPicture.asset('assets/images/86.svg'), 'chantal.fobi@gmail.com', true),
                ],
              ),
            ),

            _buildSection(
              'global.options'.tr(),
              Column(
                spacing: 15,
                children: [
                  buildInfoRowCustom(SvgPicture.asset('assets/images/84.svg'), 'profile.submittedapplications'.tr(), true, (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => ApplicationsScreen(),));
                  }),
                  buildInfoRowCustom(SvgPicture.asset('assets/images/83.svg'), 'global.wallet'.tr(), true, (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => TuitionScreen(),));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {double topSpacing = 20}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        CustomText(
          label: title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 15),
        content,
      ],
    );
  }

  
}
