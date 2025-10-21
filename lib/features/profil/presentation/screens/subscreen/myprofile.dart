import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/profil/presentation/screens/subscreen/editprofile.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Myprofile extends StatelessWidget {
  const Myprofile({super.key});

  @override
  Widget build(BuildContext context) {


      const defaultColor = Color(0xFF0065FF);
   const textColor = Color(0xFF6A737D);

  // Méthode pour créer une ligne d'information avec icône
  Widget buildInfoRow(IconData icon, String text, bool darkColor) {
    return Row(
      children: [
        Icon(icon, color: defaultColor, size: 16),
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

    Widget buildInfoRowCustom(IconData icon, String text, bool darkColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: defaultColor, size: 16),
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
                    label: 'global.modify',
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
                children: [
                  buildInfoRow(IconsaxPlusLinear.call, '+237 698 024 135', true),
                  const SizedBox(height: 4),
                  buildInfoRow(Icons.mail_outline, 'chantal.fobi@gmail.com', true),
                  const SizedBox(height: 4),
                ],
              ),
            ),

            _buildSection(
              'global.options'.tr(),
              Column(
                children: [
                  buildInfoRowCustom(IconsaxPlusLinear.document, 'profile.submittedapplications'.tr(), true),
                  const SizedBox(height: 4),
                  buildInfoRowCustom(IconsaxPlusLinear.wallet, 'global.wallet'.tr(), true),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {double topSpacing = 14}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        CustomText(
          label: title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10),
        content,
      ],
    );
  }

  
}
